#!/usr/bin/env Rscript
require(ggplot2)
require(gridExtra)
args <- commandArgs(trailingOnly = TRUE)

in_files <- NULL
files <- NULL
headings <- NULL
nodes <- NULL
mds <- NULL

outfile <- args[2]
xlabel <-args[3]
ylabel <-args[4]

in_files[1] <- args[1]
headings[1] <- paste( args[5], args[6] )
nodes[1] <- args[7]
mds[1] <- args[8]

sq <- seq(9, 30, by=3)
j <- 1
for ( i in sq ){
   j <- j+1
   in_files[j] <- args[i]
   nodes[j] <- args[i+1]
   mds[j] <- args[i+2]
}

sq<- seq(33, 91, by=29)
for( i in sq ){
   j <- j+1
   in_files[j] <- args[i]
   headings[j] <- paste( args[i+1], args[i+2] )
   nodes[j] <- args[i+3]
   mds[j] <- args[i+4]

   inner_seq <- seq(i+5, i+26 , by=3)
   for( k in inner_seq ){
      j <- j+1
      in_files[j] <- args[k]
      nodes[j] <- args[k+1]
      mds[j] <- args[k+2]
   }
}

for( i in 1:4){
   j <- 3
   files[[i]] <- read.csv(file=in_files[ (i-1)*9 + 1 ],head=TRUE,sep=",")
   for( k in ( (i-1)*9 + 2 ):( (i-1)*9 + 9 ) ){
      tmp <- read.csv(file=in_files[k], head=TRUE, sep=",")
      files[[i]][j] <- tmp$y
      j <- j+1
   }
}
print(files)
quit()

plot1 <- arrangeGrob( qp1, qp2)
plot2 <- arrangeGrob( qp3, qp4)
ggsave( plot1, file=paste( "p1-" ,outfile, sep="") )
ggsave( plot2, file=paste( "p2-", outfile, seq="") )
