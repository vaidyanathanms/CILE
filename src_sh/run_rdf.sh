#!/bin/bash

#SBATCH -A chem
#SBATCH -p burst
#SBATCH -t 12:00:00
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 32
#SBATCH --mem=2G
#SBATCH -J rdf5p00p0
#SBATCH -o rdfout.%J
#SBATCH -e rdferr.%J

module purge
module load gromacs/5.1.2


cd $SLURM_SUBMIT_DIR

echo "begin job.."
echo $PWD

# Make output directory
outdir='rdfresults_1.0'
mkdir -p ${outdir}

# Create RDF files
echo "Run rdf-c2c_fsi-COM"
srun gmx rdf -f traj_npt_main.trr -s npt_main.tpr -o rdf_c2c_fsi2com.xvg -cn nrdf_c2c_fsi2com.xvg -b 35000 -e 40000 -rmpbc yes -sf rdfc2c_fsi.txt -selrpos whole_res_com
wait

echo "Run rdf-c2c_Li-COM"
srun gmx rdf -f traj_npt_main.trr -s npt_main.tpr -o rdf_c2c_Licom.xvg -cn nrdf_c2c_licom.xvg -b 35000 -e 40000 -rmpbc yes -sf rdfc2c_li.txt -selrpos whole_res_com
wait

echo "Run rdf-c2c_fsi"
srun gmx rdf -f traj_npt_main.trr -s npt_main.tpr -o rdf_c2c_fsi2.xvg -cn nrdf_c2c_fsi2.xvg -b 35000 -e 40000 -rmpbc yes -sf rdfc2c_fsi.txt
wait

echo "Run rdf-c2c_Li"
srun gmx rdf -f traj_npt_main.trr -s npt_main.tpr -o rdf_c2c_Li.xvg -cn nrdf_c2c_Li.xvg -b 35000 -e 40000 -rmpbc yes -sf rdfc2c_li.txt
wait

echo "Run rdf-Li_fsi"
srun gmx rdf -f traj_npt_main.trr -s npt_main.tpr -o rdf_Li_fsi2.xvg -cn nrdf_Li_fsi2.xvg -b 35000 -e 40000 -rmpbc yes -sf rdfLi_fsi.txt 
wait

echo "All RDF calculations completed"
echo "move files to ${outdir}"
mv rdf_* ${outdir} 
mv rdfout* ${outdir}
mv rdfana* ${outdir}
cp rdf* ${outdir}
