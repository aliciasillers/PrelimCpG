# Prelimiary CpG Methylation Data

## Introduction

This repository contains the scripts for processing and analyzing some preliminary data for my work on plant aging, first by following a workflow to extract CpG methylation data from PacBio HiFi reads with kientics, and then by analyzing this data with the methylKit R package.

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
conda env create -n methylkitenv r-methylkit
```


