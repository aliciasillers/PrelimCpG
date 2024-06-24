#!/bin/bash
#
#SBATCH --job-name=getdmrs
#SBATCH --ntasks=1 # Number of cores
#SBATCH --nodes=1 # Ensure that all cores are on one machine
#SBATCH --mem=22G # Memory pool for all cores in MB (see also --mem-per-cpu)
#SBATCH --partition=bmh # Partition to submit to
#SBATCH --output=getdmrs.out # File to which STDOUT will be written
#SBATCH --error=getdmrs.err # File to which STDERR will be written
#SBATCH --mail-type=END,FAIL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=asillers@ucdavis.edu # Email to which notifications will be$
#SBATCH --time=1-00:00:00

set -e                                                                                  # Error if a single command fails
set -u                                                                                  # Error if un-named variables calle>set -x

# USAGE: getdmrs.sh "SAMPLELISTFILENAME"

module load conda/latest
conda activate rmethyl

Rscript --vanilla --verbose getdmrs.R $1

