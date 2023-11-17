library(tidyverse)
library(DBI)
library(glmnet)

# read in data

allcpg <- read.delim("regmatrix.tsv", sep = '\t', header = TRUE)
agelist <- as.list(readLines("agelist.txt"))
agelist <- unlist(agelist)

# perform penalized regression

regr <- glmnet(allcpg, agelist)

print(regr)

# plot

png("regplot.png")
regplot <- plot(regr)
print(regplot)
dev.off()

#get associated sites

cpgsites <- as.data.frame(as.matrix(coef(regr, s = 2))) %>% filter(s1>0)

# write data

write.table(cpgsites, "cpgsites.tsv", quote = FALSE, sep = '\t')
