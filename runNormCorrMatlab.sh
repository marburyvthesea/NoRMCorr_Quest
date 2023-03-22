#!/bin/bash
#SBATCH -A p30771
#SBATCH -p normal
#SBATCH -t 12:00:00
#SBATCH -o ./logfiles/normcorrMatlab.%x-%j.out # STDOUT
#SBATCH --job-name="slurm_matlab_normcore"
#SBATCH --mem-per-cpu=5200M
#SBATCH -N 1
#SBATCH -n 16

module purge all

cd ~

#path to file (tiff should work)

INPUT_folder=$1
echo $INPUT_files_to_analyze

#add project directory to PATH
export PATH=$PATH/projects/p30771/


#load modules to use
module load matlab/r2018a

#cd to script directory

#run  



matlab -nosplash -nodesktop -r "addpath(genpath('/projects/p30771/MATLAB/CNMF_E_jjm'));folder='$INPUT_folder';fnRunNormcorrSession(folder);exit;"
