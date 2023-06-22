#!/bin/bash
#
#SBATCH --job-name=cpgtools
#SBATCH --ntasks=10 # Number of cores
#SBATCH --nodes=1 # Ensure that all cores are on one machine
#SBATCH --mem=32G # Memory pool for all cores in MB (see also --mem-per-cpu)
#SBATCH --partition=bmh # Partition to submit to
#SBATCH --output=cpgtools.out # File to which STDOUT will be written
#SBATCH --error=cpgtools.err # File to which STDERR will be written
#SBATCH --mail-type=END # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=asillers@ucdavis.edu # Email to which notifications will be$
#SBATCH --time=1-00:00:00

# USAGE: cpgtools.sh ALIGNEDFILE SAMPLENAME

set -e                                                                                  # Error if a single command fails
set -u                                                                                  # Error if un-named variables calledset -x                                                                                  # Print commands as they run
set -x

pb-CpG-tools-v2.3.1-x86_64-unknown-linux-gnu/bin/aligned_bam_to_cpg_scores \
  --bam $1 \
  --output-prefix $2.cpg \
  --model pb-CpG-tools-v2.3.1-x86_64-unknown-linux-gnu/models/pileup_calling_model.v1.tflite \
  --threads 12
