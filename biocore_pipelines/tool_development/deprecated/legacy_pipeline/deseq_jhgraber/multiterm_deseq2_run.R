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
des <- paste("",paste(as.vector(jObj$model_formula_terms),collapse= " + "), sep = " ~ ")
print(des)
dataset <- DESeqDataSetFromMatrix(countData = countData, colData = colData, design = as.formula(des))
dataset <- dataset[rowSums(counts(dataset)) > jObj$row_sum_th, ]
summary(dataset)
dataset <- DESeq(dataset)
resultsNames(dataset)

for(i in 1:dim(as.matrix(jObj$contrasts))[1]) {
      filetemp <- paste(unlist(jObj$contrasts[i]),sep="_",collapse="-")
      filename <- paste(jObj$output_prefix,filetemp,"DESeq2out.csv", sep="_")
      print(dim(unlist(jObj$contrasts[i])))
      res <- results(dataset,c(unlist(jObj$contrasts[i])))
      summary(res)
      write.csv(as.data.frame(res),file=filename)
}
