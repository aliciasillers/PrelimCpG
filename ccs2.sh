#!/bin/bash
#
#SBATCH --job-name=ccs
#SBATCH --ntasks=24 # Number of cores
#SBATCH --nodes=1 # Ensure that all cores are on one machine
#SBATCH --mem=32G # Memory pool for all cores in MB (see also --mem-per-cpu)
#SBATCH --partition=bmh # Partition to submit to
#SBATCH --output=ccs.out # File to which STDOUT will be written
#SBATCH --error=ccs.err # File to which STDERR will be written
#SBATCH --mail-type=END,FAIL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=asillers@ucdavis.edu # Email to which notifications will be$
#SBATCH --time=1-00:00:00

# USAGE: ccs2.sh SUBREADSFILE PREFIX

set -e                                                                                  # Error if a single command fails
set -u                                                                                  # Error if un-named variables calledset -x                                                                                  # Print commands as they run
set -x

module load conda/latest
conda activate my.bio3

ccs $1 $2.hifi.bam --hifi-kinetics -j 48
