#!/bin/bash
#SBATCH -A p30771
#SBATCH -p short
#SBATCH -t 00:05:00
#SBATCH --job-name="slurm_matlab_normcorr_run"
#SBATCH -N 1
#SBATCH -n 20 
#SBATCH --mem-per-cpu=6000

module purge all

cd ~

#path to directory
INPUT_dirpath=$1
INPUT_movie_start=$2
INPUT_movie_end=$3

# other parameters for CNMF_E

INPUT_gSig=13
INPUT_gSiz=40
INPUT_Fs=20
#spatial downsampling 
INPUT_ssub=8
#use parallel processing
INPUT_parallel_enable=false

#add project directory to PATH
export PATH=$PATH/projects/p30771/

#load modules to use
module load python/anaconda3.6 

#load modules to use
module load matlab/r2018a

#cd to script directory
cd /projects/p30771/MATLAB/NoRMCorre_JJM
#run  

matlab -nosplash -nodesktop -r "dirpath = '$INPUT_dirpath';run_parallel = '$INPUT_parallel_enable';movie_start = str2num('$INPUT_movie_start');movie_end = str2num('$INPUT_movie_end');gSig=str2num('$INPUT_gSig');gSiz=str2num('$INPUT_gSiz');Fs=str2num('$INPUT_Fs');ssub=str2num('$INPUT_ssub');disp(dirpath);run('projects/p30771/MATLAB/NoRMCorre_JJM/normcorr_run_JJM.m');exit;"


