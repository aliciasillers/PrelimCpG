library(tidyverse)
library(DBI)
library(glmnet)

# read in data

allcpg <- read.delim("regmatrix.tsv", sep = '\t', header = TRUE)
allcpg <- as.matrix(allcpg)
agelist <- as.list(readLines("agelist.txt"))
agelist <- unlist(agelist)
agelist <- as.numeric(agelist)

# perform penalized regression

regr <- glmnet(allcpg, agelist)

print(regr)

# plot

png("regplot.png")
regplot <- plot(regr)
print(regplot)
dev.off()

# get best lambda (s) value

cvfit <- cv.glmnet(x = allcpg, y = agelist)
cvfit$lambda.min

# get cpg sites

cpgsites <- as.data.frame(as.matrix(coef(cvfit, s = "lambda.min"))) %>% filter(s1!=0) %>% arrange(desc(abs(s1)))


# write data

write.table(cpgsites, "cpgsites.tsv", quote = FALSE, sep = '\t')
