#!/bin/bash
#
#SBATCH --job-name=merge
#SBATCH --ntasks=10 # Number of cores
#SBATCH --nodes=1 # Ensure that all cores are on one machine
#SBATCH --mem=20G # Memory pool for all cores in MB (see also --mem-per-cpu)
#SBATCH --partition=bmh # Partition to submit to
#SBATCH --output=merge.out # File to which STDOUT will be written
#SBATCH --error=merge.err # File to which STDERR will be written
#SBATCH --mail-type=END,FAIL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=asillers@ucdavis.edu # Email to which notifications will be$
#SBATCH --time=08:00:00

module load samtools

samtools merge -o S42.5mc.hifi.bam S42.5mc.hifi.1.bam S42_AJ.5mc.hifi.bam

