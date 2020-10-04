#!/bin/bash

# SEQLIBS=()

# # サンプル名の配列を生成

# for num in {1..6}
# do
#     SEQLIBS+=( TY00${num}-${num} )
# done

# # for num in {10..18}
# # do
# #     SEQLIBS+=( TY0${num}-${num} )
# # done

# # HISAT2によるマッピング

# for seqlib in ${SEQLIBS[@]}
# do
#     hisat2 --summary-file ${seqlib}_summary_hisat2 --new-summary \
#     -p 8 -q --dta -x gene_idx \
#     -1 ${seqlib}_combined_R1_val_1.fq.gz \
#     -2 ${seqlib}_combined_R2_val_2.fq.gz \
#     -S mapping_result/${seqlib}.sam

#     rm ${seqlib}_combined_R1_val_1.fq.gz
#     rm ${seqlib}_combined_R2_val_2.fq.gz
# done

hisat2 --summary-file $1_summary_hisat2 --new-summary \
-p 16 -q --dta -x /work/index/gene_idx \
-1 /work/results/trim_result/out_TY001-1_combined_R1.fastq.gz \
-2 /work/results/trim_result/out_TY001-1_combined_R2.fastq.gz \
-S results/mapping_result/result1.sam
