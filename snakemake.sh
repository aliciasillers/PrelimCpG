#!/bin/bash
#
#SBATCH --job-name=snakemake
#SBATCH --ntasks=20 # Number of cores
#SBATCH --nodes=1 # Ensure that all cores are on one machine
#SBATCH --mem=60G # Memory pool for all cores in MB (see also --mem-per-cpu)
#SBATCH --partition=bmh # Partition to submit to
#SBATCH --output=snakemake.out # File to which STDOUT will be written
#SBATCH --error=snakemake.err # File to which STDERR will be written
#SBATCH --mail-type=END,FAIL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=asillers@ucdavis.edu # Email to which notifications will be$
#SBATCH --time=1-08:00:00

set -e                                                                     # Error if a single command fails
set -x                                                                     # Error if un-named variables calledset -x  >set -x
set -u

module load conda/latest
conda activate snakebio3

snakemake -j 20
