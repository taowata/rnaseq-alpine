#!/bin/bash

salmon index -t IRGSP-1.0_cds_2020-09-09.fasta.gz -i transcripts_index_salmon -k 31

salmon quant -i transcripts_index_salmon -p 6 -l A -1 out_TY001-1_combined_R1.fastq.gz -2 out_TY001-1_combined_R2.fastq.gz --validateMappings -o salmon_
output