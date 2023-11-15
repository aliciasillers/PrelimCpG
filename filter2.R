#script to follow filter.sh; identifies samples with less than 3% of the maximum number of sites but does not actually filter them yet, as which ones to remove will be decided manually

library("tidyverse")
library("DBI")

allcpg <- read.delim("cpgmatrixf1v2.tsv", sep = '\t', header = TRUE)

allcpg <- as.data.frame(allcpg)

samplelist <- allcpg %>%
  rowwise() %>%
  mutate(n.sites=sum(!is.na(c_across(starts_with("c"))))) %>% #problem might be with header, could try quotes
  ungroup() %>%
  filter(n.sites < (max(n.sites))*.75) %>%
  pull(pos.id)

samplelist


write(samplelist, "smallsamples.txt")
