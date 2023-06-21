#!/bin/bash
#
#SBATCH --job-name=pbindex
#SBATCH --ntasks=10 # Number of cores
#SBATCH --nodes=1 # Ensure that all cores are on one machine
#SBATCH --mem=32G # Memory pool for all cores in MB (see also --mem-per-cpu)
#SBATCH --partition=bmh # Partition to submit to
#SBATCH --output=pbindex.out # File to which STDOUT will be written
#SBATCH --error=pbindex.err # File to which STDERR will be written
#SBATCH --mail-type=END,FAIL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=asillers@ucdavis.edu # Email to which notifications will be$
#SBATCH --time=08:00:00

module load conda/latest

conda activate my.bio3

pbindex S26_K_U_AE.subreads.bam
