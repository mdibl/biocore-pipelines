#Script to look for the presence of RNA binding motifs among a set of co-regulated transcripts
#requires modification of the motifEnrichment package to consider a single RNA strand instead of DNA. 

if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("PWMEnrich")

source("http://bioconductor.org/biocLite.R")
biocLite("IRanges")

library(PWMEnrich)
library(Biostrings)
library(IRanges)
library(biomaRt)
library(GenomicRanges)

#allow all four cores to be used - NOT working in windows
registerCoresPWMEnrich(1)

#created custom functions motifEnrichment2 , motifScores2 and scanWithPWM2 to only consider motifs on coding strand
#required pointing the functions to the package using  PWMEnrich:::.internalFunction.
#The altered functions are saved in Motif_Functions_.R
#scanWithPWM2 function was altered to report 0 for matching on the alternative strand

#after creating functions, place them in namespace of the package
environment(motifEnrichment2) <- asNamespace('PWMEnrich')

environment(motifScores2) <- asNamespace('PWMEnrich')

environment(scanWithPWM2) <- asNamespace('PWMEnrich')

#deatch package, if needed
detach("package:PWMEnrich", unload=TRUE)


#####reading in all of the PWMs exported from cisBP-RNA, these were formatted with code at the end of the script
#version 2 has updated names (with RBP) and removed 298 and 049 as they were indirect to elegans
cis2=readMotifs('PWMS_list2.txt')

############################################################

#UTRs lists generated in 'UTR_analysis_markus_2019

#####generate background for all quant genes 3' UTRs using RNABP motifs
##creating background for 3'UTRs
bkg.3utr2=makePWMLognBackground(Nol.all.UTR,cis2,bg.len=100,bg.source='RNA-seq quantifiable C.elegans 3UTR')


#############Running enrichment
#runnig enrichment on UTRs of translationally promoted and repressed mRNA under DR
Enrich_Nol.pro=motifEnrichment2(Nol.up.UTR,bkg.3utr2)
Enrich_Nol.rep=motifEnrichment2(Nol.down.UTR,bkg.3utr2)

Enrich_ctl.pro=motifEnrichment2(ctl.up.UTR,bkg.3utr2)
Enrich_ctl.rep=motifEnrichment2(ctl.down.UTR,bkg.3utr2)

#write table showing the enrichment of each group of genes for each RNABP motif
write.table(data.frame(Enrich_Nol.pro$group.bg,Enrich_Nol.rep$group.bg,Enrich_ctl.pro$group.bg,
Enrich_ctl.rep$group.bg),file='M:\\Rollins\\Projects\\Colaboration\\Nol-1_3UTR_motifs_enrichment_v4.txt',sep='\t')

#show the group report of the top enriched motifs
groupReport(Enrich_Nol.pro)

#write table for showing enrichment scores for each RNABP for each gene

write.table(Enrich_Nol.pro$sequence.bg,file='M:\\Rollins\\Projects\\Colaboration\\Nol-1_promoted_3UTR_motif_scores_v1.txt',sep='\t')
write.table(Enrich_Nol.rep$sequence.bg,file='M:\\Rollins\\Projects\\Colaboration\\Nol-1_repressed_3UTR_motif_scores_v1.txt',sep='\t')
write.table(Enrich_ctl.pro$sequence.bg,file='M:\\Rollins\\Projects\\Colaboration\\Control_promoted_3UTR_motif_scores_v1.txt',sep='\t')
write.table(Enrich_ctl.rep$sequence.bg,file='M:\\Rollins\\Projects\\Colaboration\\Control_repressed_3UTR_motif_scores_v1.txt',sep='\t')


##################### Function to plot from each group based on PWMenrich output #############################
##############################################################################################################
#group should be X$group.bg 

plotMotifs=function(group1,group2){
plot_frame=cbind(group1,group2)
colnames(plot_frame)=c('group1','group2')
#hits=subset(plot_frame,select=group1:group2)
#only take highly significant motifs for final graph
sighits=subset(plot_frame,plot_frame[,1] < 0.05 | plot_frame[,2] < 0.05)
#add small value to all to be able to take log without error
sighits=sighits+0.000000000001
#take negative log
sighits=-log(sighits,2)
#turn frame into matrix
plot_mat=as.matrix(sighits)
end.plot=barplot(t(plot_mat),beside=T,col=c('seagreen','indianred'),ylab='-log2(p-value)',xlab='RNA binding protein name and motif ID',cex.lab=1.5,cex.axis=2,cex.names=1.0,
args.legend=list(title='Polysomal Association',cex=1.6,inset=c(.06,0)),legend.text=c("Increased","Decreased"))
#legend('topleft',c("Increased","Decreased"),fill=c('seagreen','indianred'),title='Polysome Association')
abline(h=4.321928)

#legend('topleft',c('No Transcription','Opposite Direction','Same Direction'),col=c('seagreen4','seagreen3','seagreen2'),lwd=5,inset=c(.06,-.22))

return(end.plot)
}
##################### EOF #################################### 

#examples running on Markus samples
plotMotifs(Enrich_Nol.pro$group.bg,Enrich_ctl.pro$group.bg)
plotMotifs(Enrich_Nol.rep$group.bg,Enrich_ctl.rep$group.bg)

plotMotifs(Enrich_Nol.pro$group.bg,Enrich_Nol.rep$group.bg)
plotMotifs(Enrich_ctl.pro$group.bg,Enrich_ctl.rep$group.bg)



# NOT NEEDED - read in hand curated list of motifs and RBPs they correspond to in c.elegans
#motif_names=read.table(file='RBP_elegans_motifs.txt',stringsAsFactors=F,sep='\t',head=T)

############# OLD code only needed once #################################
#6/19/17 revised list to remove redundant motifs and to give better names
#####reading in all of the PWMs exported from cisBP-RNA
#reads files in folder containing motifs hand slected based on homology to elegans
PWMS=list.files("C:/Users/JRollins/Documents/pwms_all_motifs")
x=NULL
temp=NULL
#file.remove('PWMS_list2.txt')
#loop to pass through each file in the folder and reformat it and write to a single file
for (x in 1:length(PWMS)){
temp=read.table(paste('C:/Users/Jrollins/Documents/',PWMS[x],sep=""),header=T)
#temp=read.table(paste('C:/Users/Jrollins/Documents/pwms_all_motifs/',PWMS[x],sep=""),header=T)

temp=t(temp) #transpose table
temp=temp[2:5,] #remove header
temp=temp*100   #multiply matrix by 100 (for percent)
rownames(temp)=c('A','C','G','T') #rename rows including U->T
#write(paste('>',substring(PWMS[x],0,nchar(PWMS[x])-4),sep=''),file='PWMS_list2.txt',append=T)
write(paste('>',motif_names[,1][x]),file='PWMS_list2.txt',append=T)
write.table(temp,'PWMS_list2.txt',col.names=F,quote=F,append=T)
}
#############################################################

