library("methylKit")
library("dplyr")
library("genomation")

# read path of desired sample list 
mysamplelist <- commandArgs(trailingOnly=TRUE)
mysamples <- as.vector(readLines(mysamplelist))

# read in full sample data
filelist <- as.vector(readLines("pathlist.txt"))
samplelist <- as.vector(readLines("samplelist.txt"))
agelist <- as.numeric(as.vector(readLines("agelist.txt")))

# create matrix of info for desired samples
fullsampleinfo <- as.data.frame(cbind(filelist, samplelist, agelist, treatmentvect))
mysampleinfo <- fullsampleinfo %>% filter(samplelist == mysamples)
#if above does not work, try: fullsampleinfo$samplelist %>% anti_join(mysamples)

# create treatment vector based on desired age cut-offs
treatmentvect <- vector(mode = "numeric", length = length(filelist))
for (i in 1:length(filelist)){
  if (agelist[i] < 45) {treatmentvect1[i] <- 1}
  else {treatmentvect1[i] <- 2}
}

# create data for methylkit analysis
mydata <- methRead(as.list(mysampleinfo$filelist), sample.id = as.list(mysampleinfo$samplelist), assembly = "AGI", #need the rest of this code line
mydata <- unite(mydata, min.per.group = 1L)

# calculate differential methylation
difmeth <- calculateDiffMeth(mydata)
difmeth25 <- getMethylDiff(difmeth, difference = 25, qvalue = 0.01)

# create bedgraph file and dmr table
bedgraph(difmeth25, file.name = "dmrs.bedgraph", col.name = "meth.diff")
dmrs <- as.data.frame(bedgraph(difmeth25, col.name = "meth.diff"))
write.table(dmrs, "dmrs.tsv", sep = '\t', quote = FALSE, row.names = FALSE)
