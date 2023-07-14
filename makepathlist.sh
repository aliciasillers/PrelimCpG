#!/bin/bash
#
#SBATCH --job-name=makepathlist
#SBATCH --ntasks=1 # Number of cores
#SBATCH --nodes=1 # Ensure that all cores are on one machine
#SBATCH --mem=2G # Memory pool for all cores in MB (see also --mem-per-cpu)
#SBATCH --partition=bmh # Partition to submit to
#SBATCH --output=makepathlist.out # File to which STDOUT will be written
#SBATCH --error=makepathlist.err # File to which STDERR will be written
#SBATCH --mail-type=END,FAIL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=asillers@ucdavis.edu # Email to which notifications will be$
#SBATCH --time=00:30:00

find ~+ -name '*.methyl.tsv' | sort > pathlist.txt
