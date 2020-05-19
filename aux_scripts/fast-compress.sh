for i in `find | grep -E "\.fastq$|\.fa$"`;
    do gzip "$i" ; done
for j in `find | grep -E "\.sra$"`;
    do rm "$j" ; done
