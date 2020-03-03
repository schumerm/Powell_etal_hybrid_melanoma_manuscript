#use with the output of plink_output_admixture_age_estimate.R 

arrArgs <- commandArgs(trailingOnly = TRUE)
if(length(arrArgs)<2){
stop("usage is Rscript estimateage_plink_admixture_decay.R output_of:plink_output_admixture_age_estimate.R mincM");
}
sIn<-as.character(arrArgs[1])
filter<-as.numeric(arrArgs[2])

oDat <- read.table(sIn , header=TRUE);
oDat <-subset(oDat, oDat$cM_start>filter)

attach(oDat);
pdf(paste(sIn,"_lddecay.pdf",sep=""))
plot(cM_stop, meanD,pch=20,cex.lab=1.3,cex.axis=1.2);

fit <- nls( meanD ~ (a * exp( -b * Dist_cM)) + c, start=list(a=1,b=30,c=0.1))

Dist_Morgan <- cM_stop / 100;
fit <- nls( meanD ~ (a * exp( -b * Dist_Morgan)) + c, start=list(a=1,b=30,c=0.1))
summary(fit);
dev.off()

