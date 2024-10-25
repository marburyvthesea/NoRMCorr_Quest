#!/bin/bash
#SBATCH -A p30771
#SBATCH -p short
#SBATCH -t 04:00:00
#SBATCH -o ./logfiles/normcorrMatlab.%x-%j.out # STDOUT
#SBATCH --job-name="slurm_matlab_normcore"
#SBATCH --mem-per-cpu=5200M
#SBATCH -N 1
#SBATCH -n 16

module purge all

cd ~

#path to file (tiff should work)

INPUT_folder=$1

# some parameters
INPUT_gSig=7


echo $INPUT_files_to_analyze

#add project directory to PATH
export PATH=$PATH/projects/p30771/


#load modules to use
module load matlab/r2018a

#cd to script directory
cd /home/jma819/NoRMCorr_Quest
#run  



#matlab -nosplash -nodesktop -r "addpath(genpath('/home/jma819/NoRMCorr_Quest/'));maxNumCompThreads(str2num(getenv('SLURM_NPROCS')));folder='$INPUT_folder';gSig=$INPUT_gSig;fnRunNormcorrSession(folder, gSig);exit;"

#echo 'finished normcorr'
echo 'grouping frames'

matlab -nosplash -nodesktop -r "addpath(genpath('/home/jma819/NoRMCorr_Quest/'));folder='$INPUT_folder';groupMotionCorrectedFiles(folder, '*motion_corrected.tif', 5);exit;"