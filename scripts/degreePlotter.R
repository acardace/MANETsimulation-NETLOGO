#!/usr/bin/env Rscript
require(ggplot2)
require(gridExtra)
require(reshape2)
args <- commandArgs(trailingOnly = TRUE)

in_files <- NULL
files <- NULL
headings <- NULL
nodes <- NULL
mds <- NULL
conf <- NULL
data <- NULL
qp <- NULL


#ARGV PARSING
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
#END OF ARGV PARSING

l <- 1
for( i in 1:4){
   #aggregating data
   j <- 3
   current <- (i-1)*9 + 1
   col_counter <- (i-1)*10 +1
   files[[i]] <- read.csv(file=in_files[ current ],head=TRUE,sep=",")

   conf[l] <- "x"
   l <- l+1
   conf[l] <- paste( "Nodes=", nodes[ current ], ",Max-degree=", mds[ current ] , sep="")
   l <- l+1

   for( k in ( current+1 ):( current + 8 ) ){
      tmp <- read.csv(file=in_files[k], head=TRUE, sep=",")
      files[[i]][j] <- tmp$y
      conf[l] <- paste( "Nodes=", nodes[ k ], ",Max-degree=", mds[ k ] , sep="")
      j <- j+1
      l <- l+1
   }
   colnames( files[[i]] ) <- conf[col_counter:(col_counter+9)]
   #melting data
   data[[i]] <- melt( files[[i]], id="x", value.name="y" ,variable.name="Experiments")
   #plotting
   qp[[i]] <- ggplot( data[[i]], aes(x=x, y=y, colour=Experiments)) + geom_density() + ggtitle(headings[current]) + xlab(xlabel) + ylab(ylabel) + xlim(c(0,25) ) + ylim( c(0,90)  )
}

#saving the plots
plot1 <- arrangeGrob( qp[[1]], qp[[2]] )
plot2 <- arrangeGrob( qp[[3]], qp[[4]] )
ggsave( plot1, file=paste( "p1-", outfile, sep="") )
ggsave( plot2, file=paste( "p2-", outfile, sep="") )
