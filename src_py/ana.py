# To analyze the RDF and n(r) of CILE-Diluent systems

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
# Input data
runall   = 0 # 0 - copy, 1 - copy & run
res_dil  = ['DFB','TTE','BTF'] # residue names
res_org_cat = 'c4c'
res_org_an  = 'PF6'
res_salt_cat = 'Li'
res_salt_an  = 'PF6'
rdfset_tuple = [("PF6","P"),
                ("PF6","FP")] #(resname,type)

n_li_salt_arr = np.array([100,100,100]) # number of lithium salt
rat_il_salt  = 2.0 #keep float
rat_dil_salt = 2.0

sh_ana_fyle = 'run_rdf_pyinp.sh' #shell script name

if res_salt_an.casefold() == res_org_an.casefold():
    res_list = [res_org_cat,res_org_an,res_salt_cat]
    hetero_salt = 0
else:
    res_list = [res_org_cat,res_org_an,res_salt_cat,res_salt_an]
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
scr_dir   = os.environ["SCRATCH"]  #  scratch dir
pack_exec = home_dir + '/tools/packmol/packmol'

if not os.path.isdir(scr_dir):
    raise RuntimeError("FATAL ERROR: ", scr_dir, " not found")

scr_dir  = scr_dir + '/cile_systems'
if not os.path.isdir(scr_dir):
    raise RuntimeError("FATAL ERROR: ", scr_dir, " not found")

#--------Main analysis---------------------------------------------
for iarr in range(len(res_dil)): # loop in solvents

    os.chdir(main_dir) # Start from main directory
    
    dil_name    = res_dil[iarr]
    resname_arr = [dil_name]
    resname_arr.extend(res_list)

    # Check directories
    head_name = res_org_cat.upper() + '_' + res_org_an.upper() \
        + '_' + dil_name
    head_dir = scr_dir + '/' + head_name
    if not os.path.isdir(head_dir):
        print(f'ERROR: {head_dir} not found')
        continue

    sysname = res_salt_cat+res_salt_an.upper() + \
        str(int(n_li_salt_arr[iarr]))+'_' + res_org_cat.upper() + \
        res_org_an.upper() + ef.convert_number(rat_il_salt) + '_' + \
        dil_name.upper() + ef.convert_number(rat_dil_salt)

    workdir = head_dir + '/' + sysname
    if not os.path.isdir(workdir):
        print(f'ERROR: {workdir} not found')
        continue

    # Check if tpr exists - then no need to do anything else
    if glob.glob(workdir+'/traj_npt_main.trr') == []:
        print(f'ERROR: No traj_npt_main.trr found in {workdir}')
        continue

    print('Making analysis input files ..')
    ef.make_anainps(workdir,res_salt_cat,res_org_cat,resname_arr,\
                    rdfset_tuple,rdfcalc=1,diffcalc=1\
                    ,autocorrcalc=0)
    
    print('Generating shell script files ...')
    ef.cpy_anash_files(sh_dir,workdir,sh_ana_fyle,res_salt_cat,\
                       res_salt_an,res_org_cat,res_org_an,\
                       dil_name,begtime=20000,endtime=30000,\
                       runall=runall,jname=sysname)
    
    # Cleaning up
    print('Cleaning up directory ..')
    ef.clean_up(workdir)


