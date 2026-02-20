# To generate initial conditions for CILE-Diluent systems
# Version: Feb-17-2026
#------------------------------------------------------------------

# Import modules
import os
import sys
import numpy as np
import re
import shutil
import glob
import math
import subprocess
import extra_functions as ef
#------------------------------------------------------------------

# Version Info
print("Generating GROMACS run-time inputs")
print("Version: Feb-17-2026")
#------------------------------------------------------------------

# Input Data

run_all  = 1 # 1-copy files and run, 0-NO run (copies files)
itp_dil  = ['tte','btfe']#,'dfbn'] # itp file names
cfg_dil  = ['tte','btfe']#,'dfbn'] # config file names
res_dil  = ['tte','BTF']#,'dfbn'] # residue names
mol_dil  = ['TTE','BTFE']#,'dfbn'] # molecule name

itp_org_cat = 'c2c1im_scaled'
cfg_org_cat = 'c2c1im'
mol_org_cat = 'c2c1im+'
res_org_cat = 'c2c'

itp_org_an  = 'PF6_scaled'
cfg_org_an  = 'PF6'
mol_org_an  = 'PF6-'
res_org_an  = 'PF6'

itp_salt_cat = 'li_scaled'
cfg_salt_cat  = 'li'
mol_salt_cat = 'Li+'
res_salt_cat = 'Li'

itp_salt_an  = 'PF6_scaled'
cfg_salt_an  = 'PF6' 
mol_salt_an  = 'PF6-'
res_salt_an  = 'PF6'

attype_fname = 'ffSCALEDcharges.itp'

rat_il_salt  = 5.0 #keep float
rat_dil_salt = 2.0

n_li_salt_arr = np.array([100,100,100]) # number of lithium salt
n_dils_arr    = rat_dil_salt*n_li_salt_arr # number of diluent molecules
n_org_cat_arr = rat_il_salt*n_li_salt_arr # number of organic cations
n_org_an_arr  = n_org_cat_arr.copy() # number of organic anions
n_an_salt_arr  = n_li_salt_arr.copy() # number of salt anions
box_arr_ang   = np.array([61,61,61]) # box size in angstroms
box_arr_nm    = box_arr_ang/10 # box size in nm

if itp_salt_an.casefold() == itp_org_an.casefold():
    itp_list = [itp_org_cat,itp_org_an,itp_salt_cat]
    cfg_list = [cfg_org_cat,cfg_org_an,cfg_salt_cat]
    res_list = [res_org_cat,res_org_an,res_salt_cat]
    mol_list = [mol_org_cat,mol_org_an,mol_salt_cat]
    nitems   = 1 + len(itp_list)
    hetero_salt = 0
else:
    itp_list = [itp_org_cat,itp_org_an,itp_salt_cat,itp_salt_an]
    cfg_list = [cfg_org_cat,cfg_org_an,cfg_salt_cat,cfg_salt_an]
    res_list = [res_org_cat,res_org_an,res_salt_cat,res_salt_an]
    mol_list = [mol_org_cat,mol_org_an,mol_salt_cat,mol_salt_an]
    nitems   = 1 + len(itp_list)
    hetero_salt = 1

#------------------------------------------------------------------

# Directory Paths
home_dir  = os.environ["HOME"]
main_dir  = os.getcwd() # current dir
gmx_dir   = home_dir + '/all_codes/files_cile/src_gmx' # gmx file super directory
sh_dir    = home_dir + '/all_codes/files_cile/src_sh'  # sh file dir
top_dir   = gmx_dir + '/top_files' # topology dir
cfg_dir   = gmx_dir + '/allcoord_files' # configuration dir
itp_dir   = gmx_dir + '/itp_files' # prm/itp file dir
mdp_dir   = gmx_dir + '/mdp_files' # mdp file dir
scr_dir   = os.environ["SCRATCH"]  # '/gpfs/wolf2/cades/phy191/scratch/vm5' # scratch dir
pack_exec = home_dir + '/tools/packmol/packmol'

if not os.path.isdir(scr_dir):
    print("FATAL ERROR: ", scr_dir, " not found")
    exit("Check scratch directory path")

scr_dir  = scr_dir + '/cile_systems'
if not os.path.isdir(scr_dir):
    os.mkdir(scr_dir)
#------------------------------------------------------------------

# Required GMX/sh and default gro/top files
mdp_fyles  = ['minim_pyinp.mdp','nvt_pyinp.mdp',\
              'npt_crescale_pyinp.mdp','npt_main_pyinp.mdp']
sh_md_fyle = 'run_md_pyinp.sh'
sh_pp_fyle = 'run_preprocess_pyinp.sh'
sh_rep_fyl = ['repeat_all.sh','repeat_md.sh']
def_inicon = 'initconf.gro'
#------------------------------------------------------------------

#Main Code
for iarr in range(len(itp_dil)): # loop in solvents

    os.chdir(main_dir) # Start from main directory
    
    dil_name    = res_dil[iarr]
    
    itp_arr     = [itp_dil[iarr]]
    cfg_arr     = [cfg_dil[iarr]] 
    resname_arr = [res_dil[iarr]]
    molname_arr = [mol_dil[iarr]]

    itp_arr.extend(itp_list)
    cfg_arr.extend(cfg_list)
    resname_arr.extend(res_list)
    molname_arr.extend(mol_list)

    # DO NOT CHANGE ORDER
    if not hetero_salt:
        molval_arr = [n_dils_arr[iarr],n_org_cat_arr[iarr],\
                      n_org_an_arr[iarr]+n_an_salt_arr[iarr],\
                      n_li_salt_arr[iarr]]
    else:
        molval_arr = [n_dils_arr[iarr],n_org_cat_arr[iarr],\
                      n_org_an_arr[iarr],n_an_salt_arr[iarr],\
                      n_li_salt_arr[iarr]].tolist()        
    
    # Make directories
    head_name = res_org_cat.upper() + '_' + res_org_an.upper() + '_' + dil_name
    head_dir = scr_dir + '/' + head_name
    if not os.path.isdir(head_dir):
        os.mkdir(head_dir)
    else:
        print(f'{head_dir} already exists')

    sysname = res_salt_cat+res_salt_an.upper() + \
        str(int(n_li_salt_arr[iarr]))+'_' + res_org_cat.upper() + \
        res_org_an.upper() + ef.convert_number(rat_il_salt) + '_' + \
        dil_name.upper() + ef.convert_number(rat_dil_salt)

    workdir = head_dir + '/' + sysname
    if not os.path.isdir(workdir):
        os.mkdir(workdir)
    else:
        print(f'{workdir} already exists')

    # Check if tpr exists - then no need to do anything else
    if not glob.glob(workdir+'/*.tpr') == []:
        print(f'***Found tpr files for {mol_org_cat}/{mol_org_an} with {mol_salt_cat}/{mol_salt_an} and {mol_dil[iarr]}***')
        print('Generating shell script files ...')
        ef.cpy_sh_files(sh_dir,workdir,sh_pp_fyle,sh_md_fyle,\
                        box_arr_nm[iarr],runall=1,\
                        outname='mixture.pdb',\
                        packname='make_mixture.inp',\
                        top_fyle= "topol.top",jname=sysname)

        # Cleaning up
        print('Cleaning up directory ..')
        ef.clean_up(workdir)

        continue
        
    print(f"***Setting up {mol_org_cat}/{mol_org_an} with {mol_salt_cat}/{mol_salt_an} and {mol_dil[iarr]}***")

    # Copy and edit mdp files
    print('Copying and editing mdp files ...')
    ef.check_cpy_mdp_files(mdp_dir,workdir,mdp_fyles,resname_arr,Tetau_vr=0.1\
                           ,Tetau_high_vr=0.1,Tetau_berend=0.1,Tetau_parrah = 0.2,\
                           Prtau_berend=4.0,Prtau_crescale=4.0,Prtau_parrah=8.0,\
                           ref_temp=300,hi_ref_temp=600,ref_pres=1.0)

    # Copy coordinate files
    print('Copying coordinate files ...')
    coord_fnames = ef.cpy_coord_files(cfg_dir,cfg_arr,workdir,\
                                      destdirname="all_coords")
        
    # Copy and edit itp files
    print('Copying itp or prm files ...')
    itp_fnames = ef.cpy_itp_files(itp_dir,itp_arr,workdir,\
                                  destdirname="itp_files")
    itp_fnames = ef.reorder_itp_fnames(itp_fnames)
    ef.gencpy(itp_dir,workdir+'/itp_files',attype_fname) # Copy atype files
    itp_fnames.insert(0,attype_fname)    


    
    # Generate top files
    print('Generating top file ...')
    ef.gen_top_file(itp_dir,itp_fnames,molname_arr,molval_arr,workdir,\
                    destdirname="itp_files",top_name="topol.top",\
                    nbfunc=1,comb_rule=3,gen_pairs='yes',\
                    fLJ=0.5,fQQ=0.5,sysname=sysname)
    
    # Generating packmol files
    print('Generating packmol file ...')
    ef.setup_packmol(coord_fnames,molval_arr,workdir,\
                     box_arr_ang[iarr],destdirname="all_coords",\
                     outname='mixture.pdb',\
                     packname = 'make_mixture.inp')

    # Run files
    print('Generating shell script files ...')
    ef.cpy_sh_files(sh_dir,workdir,sh_pp_fyle,sh_md_fyle,\
                    box_arr_nm[iarr],runall=run_all,\
                    outname='mixture.pdb',packname='make_mixture.inp',\
                    top_fyle= "topol.top",jname=sysname)


        
    # Cleaning up
    print('Cleaning up directory ..')
    ef.clean_up(workdir)

    
