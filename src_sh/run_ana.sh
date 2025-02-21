#!/bin/bash

#SBATCH -A chem
#SBATCH -p burst
#SBATCH -t 3:00:00
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 32
#SBATCH --mem=2G
#SBATCH -J ana2p00p2
#SBATCH -o anaout.%J
#SBATCH -e anaerr.%J


cd $SLURM_SUBMIT_DIR

echo "begin job.."
echo $PWD

# Make output directory
outdir='rdfresults_1.0'
mkdir -p ${outdir}

python trr2lmptrj.py
wait

export OMP_NUM_THREADS=16
./anainp.o anainp.txt

echo "All analysis calculations completed"
echo "move files to ${outdir}"
mv catan* ${outdir}
mv rdf_traj* ${outdir} 
mv anaout* ${outdir}
mv anaerr* ${outdir}
cp anainp.txt ${outdir}
