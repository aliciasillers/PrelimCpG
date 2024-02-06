# Prelimiary CpG Methylation Data

## Introduction

This repository contains the scripts for processing and analyzing some preliminary data for my work on plant aging, first by following a workflow to extract CpG methylation data from PacBio HiFi subreads, then by identifying age-associated cpg sites and differentially methylated regions.

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

### Environment for cpg site analysis in r

```bash
conda env create -n regr -f regr.yml
```

### Environment for dmr analysis in r

```bash
conda env create -n rmethyl -f rmethyl.yml
```

## Part 1: PacBio subreads to CpG data workflow

This workflow takes PacBio subreads as input and produces a .bed file and a .bw file that give the probability of methylation of each CpG site across the genome. The .bw file can be viewed in IGV or another genome browser. The .bed file will be used for further analysis in this project.	
To run a sample through this workflow, the scripts in this repo must be run in the following order with commandline input:	 
1. ccs.sh SUBREADSFILE SAMPLENAME 	
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

## Part 2: Analysis Two Ways

### Identifying Age-Associated CpG Sites (Epigenetic Clock)

#### Filtering

Because sequence coverage differs among samples, the data needs to be filtered to limit the numbers of sites that are represented in more samples than others. The first filtering script (filter1.sh) in this repository removes cpg sites that are covered in less than 30% of samples. The second (filter2.sh) returns a list of samples that have less than 10% of the maximum remaining coverage of cpg sites. It does not automatically remove the samples from the data table so that low coverage samples can be manually picked to include or exclude based on other factors. After this filtering has been completed, any remaining NA values are imputed with the column mean using the impute script (impute.sh).

#### Regression

The R package glmnet is used to perform penalized regression. 
regression.R takes the output from the imputation done in the filtering step and returns a table of cpg sites with the strongest associations with age. Run using regression.sh

### Identifying Differentially Methylated Regions (in progress)

#### Filtering

#### DMR identification with MethylKit

#### Visualization
