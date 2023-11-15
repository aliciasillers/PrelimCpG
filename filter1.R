library(tidyverse)
library("DBI")

#read input
samplelist <- as.list(readLines("samplelist.txt"))

for (i in samplelist){
  inpath <- paste0(i, ".tsv")
  assign(i, read.delim(inpath, header=TRUE, sep="\t"))
}

dflist <- list(S1, S12, S13, S14, S15, S17, S19, S2, S20, S21, S23, S25, S26, S27, S28, S3, S30, S32, S34, S36, S37, S38, S39, S40, S41, S42, S44, S5, S6, S7, S8)
rm(S1, S12, S13, S14, S15, S17, S19, S2, S20, S21, S23, S25, S26, S27, S28, S3, S30, S32, S34, S36, S37, S38, S39, S40, S41, S42, S44, S5, S6, S7, S8)

#create matrix
allcpg <- dflist %>% reduce(full_join, by='pos.id')

#filter
allcpg2 <- allcpg[rowSums(is.na(allcpg[,-1])) < 8,]
allcpg2 <- t(allcpg2)
allcpg2 <- as.data.frame(allcpg2)
allcpg2 <- sqlRownamesToColumn(allcpg2, row.names = 'pos.id')
colnames(allcpg2) <- as.character(allcpg2[1,])
allcpg2 <- allcpg2[-1,]


#write output
write.table(allcpg2, "cpgmatrixf1v2.tsv", sep = '\t', quote = FALSE, row.names = FALSE)
