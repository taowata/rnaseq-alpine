#!/bin/bash

# RNAseq解析の第一歩
# アダプター配列のトリミングとクオリティチェック
read -p "Input read1 file name:" read1
read -p "Input read2 file name:" read2
# trim_galore --paired --fastqc "resources/${read1}" "resources/${read2}" -o trim_result/ -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -a2 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT

fastp -i "resources/${read1}" -I "resources/${read2}" -3\
 -o "results/trim_result/out_${read1}" -O "results/trim_result/out_${read2}" \
 -h /results/trim_result/trimreport1.html -j /results/trim_result/report1.json -q 15 -n 10 -t 1 -T 1 -l 20 -w 16