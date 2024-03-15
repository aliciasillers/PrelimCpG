library(tidyverse)
library("DBI")

#read input
samplelist <- as.list(readLines("samplelist.txt"))

for (i in samplelist){
  inpath <- paste0(i, ".methyl.tsv")
  assign(i, as.data.frame(read.delim(inpath, header=TRUE, sep="\t")))
}

dflist <- list(S1, S12, S13, S14, S15, S16, S17, S19, S2, S20, S21, S23, S25, S26, S27, S28, S3, S30, S32, S34, S36, S37, S38, S39, S40, S41, S42, S44, S5, S6, S7, S8)
rm(S1, S12, S13, S14, S15, S16, S17, S19, S2, S20, S21, S23, S25, S26, S27, S28, S3, S30, S32, S34, S36, S37, S38, S39, S40, S41, S42, S44, S5, S6, S7, S8)
names(dflist) <- samplelist

#create matrix
allcpg <- dflist %>% reduce(full_join, by='unique.id')
dim(allcpg)

#get filter list
filtlist <- allcpg[rowSums(is.na(allcpg[,-1])) > 15,]
dim(filtlist)
rm(allcpg)

#filter each sample
for (i in 1:length(dflist)){
	dflist[[i]] <- dflist[[i]] %>% anti_join(filtlist, by = 'unique.id')
}

#output data
for (i in 1:length(dflist)){
  names(dflist[i])
  outpath <- paste0(names(dflist[i]), ".filt.methyl.tsv")
  tmp <- as.data.frame(dflist[[i]])
  write.table(tmp, outpath, sep = '\t', quote = FALSE, row.names = FALSE)
}
