# To analyze the RDF and n(r) of CILE-Diluent systems

# Import modules
import os
import sys
import numpy
import re
import shutil
import glob
import math
import subprocess
#from make_gmx_inputs import * # function definitions

# Input data
salt_name = 'LiFSI' # main salt
IL_name = 'C2C1Im'  # ionic liquid
dil_name = 'TTE'    # diluent
N_Li = 100 # number of Li molecules
r_IL_to_Li_arr = [2.0,5.0] # ratio of IL to Li
r_dil_to_Li_arr = [[0.0,0.2,0.6,2.0],
                   [0.0,0.5,1.5,5.0]] # ratio of dil to Li

#---------directory info---------------------------------------
maindir    = os.getcwd() #src_py dir
home_path  = '/home/vm5'
scr_path   = '/lustre/or-scratch/cades-birthright/vm5'
src_f90    = home_path + '/all_codes/files_cile/src_f90' #f90 dir
src_lmp    = home_path + '/all_codes/files_cile/src_lmp' #lmp dir
src_tcl    = home_path + '/all_codes/files_cile/src_tcl' #tcl dir
scratchdir = scr_path  + '/cile_diluent' #head scratch dir

#--------Check scratchdir------------------------------------
if not os.path.isdir(scratchdir):
    raise RuntimeError(scratchdir + ' not found')

scrdir = scratchdir + '/' + salt_name + str(N_Li) # scr dir
#--------Main analysis---------------------------------------
for k, r_IL2Li in enumerate(r_IL_to_Li_arr):
    d, i = math.modf(r_IL2Li)
    r_il2li_str = str(int(i)) + 'p' + str(d).split('.')[1]
    for r_dil2Li in r_dil_to_Li_arr[k]:
        d2, i2 = math.modf(r_dil2Li)
        r_dil2Li_str = str(int(i2)) + 'p' + str(d2).split('.')[1]
        workdir = scrdir + '_' + IL_name + r_il2li_str \
                   + '_' + dil_name + r_dil2Li_str
        
        if not os.path.isdir(workdir):
            raise RuntimeError(scratchdir + ' not found')

        print(f'Analyzing {il_name}:Li = {r_IL2Li}, {dil_name}:Li = {r_dil2Li}')

