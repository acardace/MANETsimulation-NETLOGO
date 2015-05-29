#!/usr/bin/env Rscript
require(ggplot2)
require(gridExtra)
args <- commandArgs(trailingOnly = TRUE)

in_files <- NULL
files <- NULL
headings <- NULL
xranges <- NULL
yranges <- NULL
nodes <- NULL
mds <- NULL

outfile <- args[2]
xlabel <-args[3]
ylabel <-args[4]

in_files[1] <- args[1]
headings[1] <- paste( args[5], " ", args[6] )
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
   headings[j] <- paste( args[i+1], " ", args[i+2] )
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

for( i in 1:j ){
   files[i] <- read.csv(file=in_files[i],head=TRUE,sep=",")
   xranges[i] <-range(files[i]$x)
   yranges[i] <-range(files[i]$y)
}

#TOFINISH

qp1 <- qplot(file1$x,file1$y, alpha=1, geom="smooth", xlim=xrange1, ylim=yrange1, xlab=xlabel, ylab=ylabel, main=heading1) + theme(legend.position="none")
qp2 <- qplot(file2$x,file2$y, alpha=1, geom="smooth", xlim=xrange2, ylim=yrange2, xlab=xlabel, ylab=ylabel, main=heading2) + theme(legend.position="none")
qp3 <- qplot(file3$x,file3$y, alpha=1, geom="smooth", xlim=xrange3, ylim=yrange3, xlab=xlabel, ylab=ylabel, main=heading3) + theme(legend.position="none")
qp4 <- qplot(file4$x,file4$y, alpha=1, geom="smooth", xlim=xrange4, ylim=yrange4, xlab=xlabel, ylab=ylabel, main=heading4) + theme(legend.position="none")
result <- arrangeGrob( qp1, qp2 ,qp3, qp4)
ggsave( result, file=outfile)
