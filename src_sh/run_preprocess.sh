#!/bin/bash
# Optimized code from Subil/Omar -  OLCFHELP-22622 [cades-help] Unable to run Gromacs utilities (Check email: June-03-2025)
# Instructions to build GROMACS are in this email
# Date: July-02-2025

#SBATCH -A chem
#SBATCH -p burst
#SBATCH -t 23:00:00
#SBATCH -N 1                    # 1 node
#SBATCH --ntasks-per-node=1     # 1 task/node
#SBATCH -c 1                    # 1 core/task
#SBATCH --mem=0
#SBATCH -J p_I5p0D0p0L100
#SBATCH -o out.%J
#SBATCH -e err.%J

# Load modules
module reset
module load intel mkl fftw hwloc cmake

# Export gcc path and num_threads
export LD_LIBRARY_PATH=/sw/cades-open/gcc/12.2.0/lib64:$LD_LIBRARY_PATH
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}

# Initializing jobs
cd $SLURM_SUBMIT_DIR
echo "begin job @start time: ${date}"
echo $PWD

mkdir -p initdir
mkdir -p outdir
mkdir -p trajfiles

# Run command
gmx="${HOME}/gromacs-2024.5/install/bin/gmx_mpi "

# generate packmol files
~/tools/packmol/packmol < make_mixture.inp
wait

# editconf box
srun ${gmx} editconf -f mixture.pdb -bt cubic -d 0.5 -o main.pdb
wait

# make tpr file
srun ${gmx} grompp -f minim.mdp -p topol.top -c main.pdb -o enermin.tpr
wait

cp *.pdb initdir/
