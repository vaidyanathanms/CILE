# To generate initial conditions for CILE-Diluent systems
# Version: Feb-05-2025
#------------------------------------------------------------------

# Import modules
import os
import sys
import numpy
import re
import shutil
import glob
import math
import subprocess
from make_gmx_inputs import * # function definitions
#------------------------------------------------------------------

# Version Info and # of input args for parsing thermostat coeff
print("Generating GROMACS run-time inputs")
print("Version: Feb-05-2025")
if len(sys.argv) == 1:
    coeff_fyle = 'None' 
elif len(sys.argv) == 2:
    coeff_fyle = str(sys.argv[1])
else:
    print('Unknown number of arguments: ', len(sys.argv),\
          str(sys.argv))
    exit()
#------------------------------------------------------------------

# Input Data

run_all  = 0 # 1-copy files and run, 0-NO run (copies files)
nitems   = 3 # Number of different moieties in the simulation
itp_arr  = ['c4c1Im','ntf2','li'] # itp file names
topname  = 'Li_BMIm_TFSI_BTFE.top' # topology file name
nmol_arr = {}


norg_arr  = [2237,1187,1451] # number of organic solvents
nwat_arr  = [4610,5330,2017] # number of water molecules (for cosolvents)
box_arr   = [11,11,13] # box size for solvent only. cosolvent=+1
nchains   = 1     # number of polymer chains
npoly_res = 22  # number of polymer residues

#------------------------------------------------------------------

# Directory Paths
main_dir  = os.getcwd() # current dir
gmx_dir   = '../src_gmx' # gmx file super directory
top_dir   = gmx_dir + '/solv_files/topol' # topology dir
cfg_dir   = gmx_dir + '/solv_files/initguess' # configuration dir
itp_dir   = gmx_dir + '/solv_files/prm_itp' # prm file dir
mdp_dir   = gmx_dir + '/' + 'mdp_files' # mdp file dir
sh_dir    = gmx_dir + '/' + 'sh_files' # sh file dir
scr_dir   = '/gpfs/alpine/bip189/scratch/vaidyams' # scratch dir

if not os.path.isdir(scr_dir):
    print("FATAL ERROR: ", scr_dir, " not found")
    exit("Check scratch directory path")
scr_dir  = scr_dir + '/lignin'
if not os.path.isdir(scr_dir):
    os.mkdir(scr_dir)
#------------------------------------------------------------------

# Required GMX/sh and default gro/top files
mdp_fyles  = ['minim_pyinp.mdp','nvt_pyinp.mdp',\
              'npt_berendsen_pyinp.mdp','npt_main_pyinp.mdp',\
              'nvt_high_pyinp.mdp']
sh_md_fyle = 'run_md_pyinp.sh'
sh_pp_fyle = 'run_preprocess_pyinp.sh'
sh_rep_fyl = ['repeat_all.sh','repeat_md.sh']
def_inicon = 'initconf.gro'
#------------------------------------------------------------------

# Check input dimension consistency
if inp_type == 'cosolvents':
    check_arr_dim(len(otyp_arr),len(oname_arr),len(wtyp_arr),\
                  len(wname_arr),len(norg_arr), len(nwat_arr),\
                  len(temp_arr),len(hi_t_arr),len(box_arr))
    solv_len = len(otyp_arr)
elif inp_type == 'melts':
    solv_len = 0
#------------------------------------------------------------------

#Main Code
for inp_val in range(solv_len): # loop in solvents

    o_sol_typ,solv_name,wat_type,wat_name,n_orgsolv,nwater,\
        ref_temp,hi_ref_t,box_dim = assign_vals(otyp_arr,oname_arr,\
                                                wtyp_arr,wname_arr,\
                                                norg_arr,nwat_arr,\
                                                box_arr,temp_arr,\
                                                hi_t_arr,inp_type,\
                                                inp_val)

    for casenum in range(len(run_arr)): # loop in runarr

        print("Preparing initial conditions for: ", biomass,\
              o_sol_typ, run_arr[casenum])

        # Make directories
        head_dir = scr_dir + '/' + inp_type
        if not os.path.isdir(head_dir):
            print(head_dir, " does not exist")
            print("ERR: Create path")
            continue

        poly_dir = head_dir + '/' + biomass
        if not os.path.isdir(poly_dir):
            print(poly_dir, " does not exist")
            print("ERR: Create path")
            continue

        if inp_type == 'melts':
            poly_dir = poly_dir + '/' + disperse
            if not os.path.isdir(poly_dir):
                print(poly_dir, " does not exist")
                print("ERR: Create path")
                continue

        rundir = poly_dir + '/run_' + str(run_arr[casenum])
        if not os.path.isdir(rundir):
            print(rundir, " does not exist")
            print('ERR: Create path and input top/pdb files first')
            continue

        workdir1 = set_working_dir(rundir,inp_type,o_sol_typ)

        # Set thermostat/top variables (change if there is a temp sweep)
        Tetau_nvt,Tetau_highnvt,Tetau_berend,Tetau_parrah,Prtau_berend,\
            Prtau_parrah,ref_pres,melt_topname=couple_coeff(inp_type,\
                                                            coeff_fyle)

        # Find tc_groups
        tc_grp,tc_typ=create_tcgrps(inp_type,npoly_res,solv_name,wat_name)

        # Copy and edit mdp files
        check_cpy_mdp_files(mdp_dir,workdir1,mdp_fyles,inp_type,Tetau_nvt\
                            ,Tetau_highnvt,Tetau_berend,Tetau_parrah,\
                            Prtau_berend,Prtau_parrah,ref_temp,hi_ref_t,\
                            ref_pres,tc_grp,tc_typ,main_dir,coeff_fyle)

        # Check for tpr files. Re-edit run_md.sh irrespective of
        # whether tpr files are found. Edit run_pp.sh iff cont_run = 0
        cont_run = cpy_sh_files(sh_dir,workdir1,sh_pp_fyle,sh_md_fyle)

        # Check for pdb/psf/top files of the melt/polymer
        poly_conffile,poly_topfile=check_inp_files(workdir1,\
                                                   melt_topname)
        # Write index groups
        indx_fyle = create_indxgrps(workdir1,inp_type,npoly_res,
                                    solv_name,wat_name)

        # Copy/edit top/conf/itp files for solvents/cosolvents
        ff_dir = create_ff_dir(workdir1)
        if inp_type == 'solvents' or inp_type == 'cosolvents':
            if cont_run == 0:
                # sol_top/sol_itp/sol_cfg are arrays
                sol_top,sol_itp,sol_cfg=cpy_solv_files(top_dir,cfg_dir,\
                                                       itp_dir,ff_dir,\
                                                       inp_type,o_sol_typ,\
                                                       wat_type)
                # check whether or not system is rerunning
                poly_topedit = edit_main_top_file(poly_topfile,ff_dir,\
                                                  sol_top,sol_itp,workdir1)

            else: #already present
                poly_topedit = poly_topfile

        # Copy all shell script for running
        for fsh_name in sh_rep_fyl:
           if not os.path.exists(workdir1 + '/' + fsh_name):
                gencpy(sh_dir,workdir1,fsh_name)

        # Change to working directory
        os.chdir(workdir1)

        # Make an outdir for writing job files from summit
        sum_out_dir = workdir1 + '/outdir'
        if not os.path.isdir(sum_out_dir):
            os.mkdir(sum_out_dir)

        # Edit pre-processing shell script files iff cont_run = 0
        if cont_run == 0: 
            if inp_type == 'melts':
                edit_pp_files(biomass,inp_type,poly_conffile,0,0,\
                              poly_topedit,'None','None',sh_pp_fyle\
                              ,ff_dir,'None',0,indx_fyle)
            elif inp_type == 'solvents':
                edit_pp_files(biomass,inp_type,poly_conffile,n_orgsolv\
                              ,0,poly_topedit,o_sol_typ,'None',\
                              sh_pp_fyle,ff_dir,sol_cfg,box_dim,indx_fyle)
            elif inp_type == 'cosolvents':
                edit_pp_files(biomass,inp_type,poly_conffile,n_orgsolv\
                              ,nwater,poly_topedit,o_sol_typ,wat_type,\
                              sh_pp_fyle,ff_dir,sol_cfg,box_dim,indx_fyle)
        else: # check for initconf.gro
            if os.path.exists(def_inicon):
                poly_conffile = def_inicon
            

        # Edit run_md shell script files always
        edit_md_files(biomass,inp_type,poly_conffile,poly_topedit,\
                      o_sol_typ,sh_md_fyle,indx_fyle)

        # Submit preprocess job
        if run_all:
            if cont_run == 0:
                print("Running all: repeat_all.sh")
                subprocess.call(["chmod", "777", "repeat_all.sh"])
                subprocess.call(["./repeat_all.sh"])
            else:
                print("Running just MD part: repeat_md.sh")
                subprocess.call(["chmod", "777", "repeat_md.sh"])
                subprocess.call(["./repeat_md.sh"])

        # Write end of loop and return directory handle to main directory
        print( "End of run number: ", run_arr[casenum])
        os.chdir(main_dir)# current dir
