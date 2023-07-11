library("tidyverse")

#read input

samplename <- commandArgs(trailingOnly=TRUE)
inpath <- paste0(samplename,".cpg.combined.bed")
input <- read.delim(inpath, header=FALSE, sep="\t")

#columns as vectors

x1 <- as.vector(input[,1]) #chromosome name
x3 <- as.vector(input[,3]) #end position
x6 <- as.vector(input[,6]) #coverage
x9 <- as.vector(input[,9]) #percent methylated

#unique.id

createid <- function(x1,x3){
  paste0(x1,".",x3)
}

unique.id <- map2(x1, x3, createid)
unique.id <- unlist(unique.id)

#chrom

chrom <- x1

#pos

pos <- x3

#strand

createstrand <- function(x1){
  paste0("F")
}

strand <- map(x1, createstrand)
strand <- unlist(strand)

#coverage

coverage <- x6

#%methyl

methyl <- x9

#%unmethyl

create.unmethyl <- function(x9){
  z <- 100 - x9
  return(z)
}

unmethyl <- map(x9, create.unmethyl)
unmethyl <- unlist(unmethyl)

#combine columns

output <- cbind(unique.id, chrom, pos, strand, coverage, methyl, unmethyl)

#write output

outpath <- paste0(samplename,".methyl.tsv")
write.table(output, outpath, row.names=FALSE, col.names=TRUE, sep="\t", quote=FALSE)
