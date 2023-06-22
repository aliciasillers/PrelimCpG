#!/bin/bash
#
#SBATCH --job-name=jasmine
#SBATCH --ntasks=10 # Number of cores
#SBATCH --nodes=1 # Ensure that all cores are on one machine
#SBATCH --mem=32G # Memory pool for all cores in MB (see also --mem-per-cpu)
#SBATCH --partition=bmh # Partition to submit to
#SBATCH --output=jasmine.out # File to which STDOUT will be written
#SBATCH --error=jasmine.err # File to which STDERR will be written
#SBATCH --mail-type=END,FAIL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=asillers@ucdavis.edu # Email to which notifications will be$
#SBATCH --time=1-00:00:00

# USAGE: jasmine.sh HIFIFILE PREFIX
#add '.1' to sample name for prefix if some 5mc.hifi data already exists

set -e                                                                                  # Error if a single command fails
set -u                                                                                  # Error if un-named variables calledset -x                                                                                  # Print commands as they run
set -x

module load conda/latest
conda activate my.bio3

jasmine $1 $2.5mc.hifi.bam
