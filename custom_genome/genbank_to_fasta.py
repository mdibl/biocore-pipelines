## Convert genbank sequence file to fasta

from Bio import SeqIO

with open("DUP144_glh-1 deletion_spliced_transcript.gb", "rU") as input_handle:
    with open("DUP144_glh-1 deletion_spliced_transcript.fasta", "w") as output_handle:
        sequences = SeqIO.parse(input_handle, "genbank")
        count = SeqIO.write(sequences, output_handle, "fasta")
print("Converted %i records" % count)