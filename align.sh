#!/bin/bash
#
#SBATCH --job-name=align
#SBATCH --ntasks=12 # Number of cores
#SBATCH --nodes=1 # Ensure that all cores are on one machine
#SBATCH --mem=32G # Memory pool for all cores in MB (see also --mem-per-cpu)
#SBATCH --partition=bmh # Partition to submit to
#SBATCH --output=align.out # File to which STDOUT will be written
#SBATCH --error=align.err # File to which STDERR will be written
#SBATCH --mail-type=END,FAIL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=asillers@ucdavis.edu # Email to which notifications will be$
#SBATCH --time=2-00:00:00

set -e                                                                                  # Error if a single command fails
set -u                                                                                  # Error if un-named variables calledset -x                                                                                  # Print commands as they run

module load samtools
module load conda/latest
conda activate my.bio3

pbmm2 align /home/asillers/Genome/farr1.mmi S21.5mc.hifi.bam S21.5mc.aligned.bam --sort
