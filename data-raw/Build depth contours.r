#########################################################################################################
#
# Generate depth contours from the 2019 GEBCO data (https://www.gebco.net/)
# using GMT (https://www.soest.hawaii.edu/gmt/) 
#
# uses gmt grdcontour, gmt connect, gmt simplify, and sed utility
# run in cmd on Windows, but easily converted to Linux
#
#########################################################################################################

#########################################################################################################
# Set working DIR gofor GEBCO
DIR<-"c:/Projects/GEBCO/2019/"

# Define contours to extract
cont<-c(25,50,75,100,150,200,250,300,350,400,450,500,550,600,650,700,750,800,850,900,950,1000,1250,1500,2000,2500,3000,3500,4000,4500,5000,5500,6000,7000,8000,9000,10000)

# Write these as definition files to external files for use by GMT grdcontour
for(i in 1:length(cont)) {
  x<-file(paste(DIR,"c",cont[i],".def",sep=""))
  cat("-",cont[i],"\n",sep="",file=x)
  close(x)
}

# Write a external batch file to process all of them
# Note this uses dimensions at 150/200/-22/-60 for NZ domain (i.e., +150/+200/-22/-60 defines xmin/xmax/ymin/ymax (wesn))
unlink(paste(DIR,"Build.bat",sep=""))
x<-file(paste(DIR,"Build.bat",sep=""),"w")
for(i in 1:length(cont)) {
  #grdcontour GEBCO_2019.nc -Cc2000.def -R+150/200/-60/-22 -JX10 -Fl -Dc2000.gmt > c2000.log
  #gmt connect c0.gmt > c0.gmt2
  #gmt simplify c0.gmt2 -T3000e > c0.gmt3
  #sed "s/>/NA NA NA/g" c0.gmt3 > c0.dat
  # Extract the contour
  cat("grdcontour GEBCO_2019.nc -C",paste("c",cont[i],".def",sep="")," -Rg+150/+200/-60/-22 -B+150+200-60-22 -JX10 -Fl -D",
      paste("c",cont[i],".gmt",sep="")," > ",paste("c",cont[i],".log",sep=""),"\n",file=x,sep="")
  # Join up contours to make closed bathymentric contours where possible/appropriate
  cat("gmt connect ",paste("c",cont[i],".gmt",sep="")," > ",paste("c",cont[i],".gmt2\n",sep=""),file=x,sep="")
  # Simplify contours to a lower resolution (in this case, 1km (=1000 meters specfified as 1000e) between points)
  cat("gmt simplify ",paste("c",cont[i],".gmt2",sep="")," -T1000e > ",paste("c",cont[i],".gmt3\n",sep=""),file=x,sep="")
  # process the file so that it is suitable for reading into R, with NAs delimiting closed contours
  cat("sed \"s/>/NA NA NA/g\" ", paste("c",cont[i],".gmt3",sep="")," > ",paste("c",cont[i],".dat\n",sep=""),file=x,sep="")
}  
close(x)

#########################################################################################################
# Run build.bat in DIR - run this from the command line in the GEBCO directory
# build.bat


#########################################################################################################
# read the generated contours back into  R
for(i in 1:length(cont)) {
  res<-read.table(paste(DIR,"c",cont[i],".dat",sep=""),header=F,as.is=T,flush=T,col.names=c("x","y","z"),skip=1)[,1:2]
  names(res)<-c("x","y")
  res$x<-as.numeric(res$x)
  res$y<-as.numeric(res$y)
  res$x<-ifelse(res$x<0,res$x+360,res$x)
  assign(paste("nz.",cont[i],"m",sep=""),res,pos=1)
}

nz.available.contours<-cont

#nz()
#nz.depth(500)
#nz.lines(nz.500m$x,nz.500m$y,col="red")
#nz.lines(nz.600m$x,nz.600m$y,col="blue")

#########################################################################################################
# Write to dump file
DIR2<-"C:/Users/alist/OneDrive/Projects/Software/nzPlot/nzPlot/data/"

a <- objects(pattern = "nz.*m")
for (i in 1:length(a)) {
  save(list=a[i],file=paste(DIR2,a[i],".rda",sep=""))
}
a
save(list="nz.available.contours",file=paste(DIR2,"nz.available.contours.rda",sep=""))
rm(a)

#########################################################################################################
# Clean up the directory of all temporary files
DIR<-"c:/Projects/GEBCO/2019/"
for(i in 1:length(cont)) {
  unlink(paste(DIR,"c",cont[i],".def",sep=""))
  unlink(paste(DIR,"c",cont[i],".log",sep=""))
  unlink(paste(DIR,"c",cont[i],".gmt",sep=""))
  unlink(paste(DIR,"c",cont[i],".gmt2",sep=""))
  unlink(paste(DIR,"c",cont[i],".gmt3",sep=""))
  unlink(paste(DIR,"c",cont[i],".dat",sep=""))
}  
#end
