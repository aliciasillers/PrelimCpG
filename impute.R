library(tidyverse)
library(glmnet)
library(tidyr)
library(DBI)

# read in data

allcpg <- read.delim("cpgmatrixf1v2.tsv", sep = '\t', header = TRUE)
allcpg <- as.data.frame(allcpg)

# impute NAs with mean

#allcpg <- makeX(allcpg, na.impute = TRUE)
allcpg <- sqlColumnToRownames(allcpg, row.names='pos.id')
allcpg <- replace_na(allcpg, as.list(colMeans(allcpg,na.rm=T)))
allcpg <- sqlRownamesToColumn(allcpg, row.names='pos.id')
allcpg <- as.matrix(allcpg)

#write output

write.table(allcpg, "regmatrix.tsv", sep = '\t', quote = FALSE, row.names = FALSE)
