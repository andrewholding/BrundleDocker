source("https://bioconductor.org/biocLite.R")
biocLite("DESeq2")
biocLite("DiffBind")
biocLite("Rsamtools")
biocLite("lattice")

#Install packages for Rmarkdown
install.packages("formatR")
install.packages("rprojroot")
install.packages("rmarkdown")


#Install modified DiffBind
URL <- paste0("https://raw.githubusercontent.com/",
      "andrewholding/BrundleDevelopment/master/Diffbind/DiffBind_2.5.6.tar.gz")
download.file(URL, destfile = "./DiffBind_2.5.6.tar.gz", method="wget")
install.packages("DiffBind_2.5.6.tar.gz", repos = NULL, type="source")

install.packages("devtools")
library(devtools)

install_github("AndrewHolding/Brundle")
install_github("AndrewHolding/BrundleData")
