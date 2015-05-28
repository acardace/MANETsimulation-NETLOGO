#!/usr/bin/env Rscript
require(ggplot2)
require(gridExtra)
args <- commandArgs(trailingOnly = TRUE)
xfile1 <- args[1]
outfile <- args[2]
xlabel <-args[3]
ylabel <-args[4]
heading1 <- args[5]

xfile2 <- args[6]
heading2 <- args[7]

xfile3 <- args[8]
heading3 <- args[9]

xfile4 <- args[10]
heading4 <- args[11]

file1 <- read.csv(file=xfile1,head=TRUE,sep=",")
xrange1 <-range(file1$x)
yrange1 <-range(file1$y)

file2 <- read.csv(file=xfile2,head=TRUE,sep=",")
xrange2 <-range(file2$x)
yrange2 <-range(file2$y)

file3 <- read.csv(file=xfile3,head=TRUE,sep=",")
xrange3 <-range(file3$x)
yrange3 <-range(file3$y)

file4 <- read.csv(file=xfile4,head=TRUE,sep=",")
xrange4 <-range(file4$x)
yrange4 <-range(file4$y)


qp1 <- qplot(file1$x,file1$y, alpha=1, geom="smooth", xlim=xrange1, ylim=yrange1, xlab=xlabel, ylab=ylabel, main=heading1) + theme(legend.position="none")
qp2 <- qplot(file2$x,file2$y, alpha=1, geom="smooth", xlim=xrange2, ylim=yrange2, xlab=xlabel, ylab=ylabel, main=heading2) + theme(legend.position="none")
qp3 <- qplot(file3$x,file3$y, alpha=1, geom="smooth", xlim=xrange3, ylim=yrange3, xlab=xlabel, ylab=ylabel, main=heading3) + theme(legend.position="none")
qp4 <- qplot(file4$x,file4$y, alpha=1, geom="smooth", xlim=xrange4, ylim=yrange4, xlab=xlabel, ylab=ylabel, main=heading4) + theme(legend.position="none")
result <- arrangeGrob( qp1, qp2 ,qp3, qp4)
ggsave(result, file=outfile)
