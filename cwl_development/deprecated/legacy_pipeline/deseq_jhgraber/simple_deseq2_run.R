library("rjson")
args <- commandArgs(trailingOnly = TRUE)
jObj <- fromJSON(file = args[1])
summary(jObj)
jObj

library("DESeq2")
countData <- as.matrix(read.table(jObj$count_file_name, header = TRUE, sep = jObj$separator, dec = '.', row.names = jObj$gene_col_title))
summary(countData)
countData <- round(countData)
colData <- as.matrix(read.table(jObj$design_file_name, header = TRUE, sep = jObj$separator))
summary(colData)
dataset <- DESeqDataSetFromMatrix(countData = countData, colData = colData, design = as.formula(paste("",jObj$model_formula, sep = " ~ ")))
dataset <- dataset[rowSums(counts(dataset)) > jObj$row_sum_th, ]
summary(dataset)
dataset <- DESeq(dataset)
res <- results(dataset,c(jObj$contrast))
summary(res)
write.csv(as.data.frame(res),file=paste(jObj$output_prefix,"DESeq2out.csv", sep="_"))
