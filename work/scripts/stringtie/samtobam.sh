#!/bin/bash
# -@オプションでソート処理の並列化(複数スレッドでの実行)ができる。環境に応じて数値を変更
samtools sort -@ 2 -O bam -o /work/results/bam_result/sort1.bam /work/results/mapping_result/result1.sam 