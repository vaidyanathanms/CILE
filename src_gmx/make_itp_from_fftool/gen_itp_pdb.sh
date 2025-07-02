# Author: Vaidyanathan M. Sethuraman
# Date: June-30-2025
# Have to do for each molecule one-by-one or else files will be overwritten
# config.pdb/simbox.xyz and field.top should be renamed at the end as well
# Copy the pack.inp generated in the first step to a new file to avoid confusion
# I have always used rho=1 
############ Requirements############################################################
# Copy il.ff from fftool directory to the current folder
####################################################################################

molarr=('c4c1im') #'c2c1im' 'fsi') # Give the molecule name WITHOUT any extensions
for molname in "${molarr[@]}"; do

    echo "Generating gmx files for ${molname} ..."

    moldir="${molname}_files"
    mkdir -p ${moldir}

    fname="${HOME}/tools/clandp/${molname}.zmat"
    if [ ! -f "${fname}" ]; then
	echo "${fname} not found .."
	continue
    fi

    echo "Copying ${molname}.zmat from clandp ..."
    cp ${fname} .
    wait

    echo "Running fftool ..."
    python3 ~/tools/fftool/fftool 1 ${molname}.zmat -r 1
    wait

    echo "Running packmol ..."
    cp pack.inp pack_${molname}.inp
    ~/tools/packmol/packmol < pack_${molname}.inp
    wait

    echo "Generating GROMACS scripts ..."
    python3 ~/tools/fftool/fftool 1 ${molname}.zmat -r 1 --mix a -gmx
    wait

    echo "Renaming and copying all config and interaction files ..."

    mv ${molname}.zmat ${moldir}/
    mv pack_${molname}.inp ${moldir}/
    mv pack.inp ${moldir}/
    mv ${molname}_pack.xyz ${moldir}/
    mv run.mdp ${moldir}/
    mv config.pdb ${moldir}/${molname}.pdb
    mv simbox.xyz ${moldir}/${molname}_single.xyz
    mv field.top  ${moldir}/${molname}.top
    wait

    echo "${molname} completed..."
    
done 
