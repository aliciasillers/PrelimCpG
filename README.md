# Prelimiary CpG Methylation Data

## Introduction

This repository contains the scripts for processing and analyzing some preliminary data for my work on plant aging, first by following a workflow to extract CpG methylation data from PacBio HiFi subreads, and then by analyzing this data with the methylKit R package.

## Conda Environment Creation

### Environment for PacBio CpG workflow without snakemake

```bash
conda env create -n my.bio3 pbccs pbjasmine pbmm2

#or using the my.bio3.yml file in this repo
conda env create -n my.bio3 -f my.bio3.yml
```

### Environment for PacBio CpG workflow with snakemake

```bash
conda env create -n snakebio3 pbccs pbjasmine pbmm2 snakemake

#or using the snakebio3.yml file in this repo
conda env create -n snakebio3 -f snakebio2.yml
```

### Environment for analysis with methylKit

```bash
#works best if you use the rmethyl.yml file in this repo rather than listing packages on command line
conda env create -n rmethyl -f rmethyl.yml
```

## PacBio subreads to CpG data workflow

This workflow takes PacBio subreads as input and produces a .bed file and a .bw file that give the probability of methylation of each CpG site across the genome. The .bw file can be viewed in IGV or another genome browser. The .bed file will be used for further analysis in this project.	
To run a sample through this workflow, the scripts in this repo must be run in the following order with commandline input:	 
1. ccs2.sh SUBREADSFILE SAMPLENAME 	
2. jasmine.sh HIFIFILE SAMPLENAME	
3. align.sh 5MCFILE SAMPLENAME	
4. cpgtools.sh ALIGNEDFILE SAMPLENAME	

The merge.sh script was used in between steps 2 and 3 for some samples that had both subreads and already existing 5mc.hifi.bam files.	

The output .bed file will have the following tab-delimited columns of data:	

1. reference name
2. start coordinate
3. end coordinate
4. modification probability
5. haplotype
6. coverage
7. estimated modified site count (extrapolated from model modification probability)
8. estimated unmodified site count (extrapolated from model modification probability)
9. discretized modification probability (calculated from estimated mod/unmod site counts)

## methylKit workflow

Because methylKit is designed to be used with methylation data from bisulfite sequencing, it takes input data in a couple of formats specific to that method of data generation. One of these input formats is a tab-delimited file with the following columns of data:	
1. unique.id	
2. chromosome name	
3. site position	
4. strand	
5. coverage	
6. percent methylated	
7. percent unmethylated	

As a result, the .bed file(s) from the previous workflow needs to be modified to fit this format. The methylformat.R and methylformat.sh scripts perform this reformatting. The usage is as follows:	

methylformat.sh SAMPLENAME	

This script will activate the rmethyl conda environment and run the R script with the sample name you indicate on the command line. The output will be a .tsv file with the correct columns needed for use with methylKit. Note that strand is indicated as 'F' for everything. 
