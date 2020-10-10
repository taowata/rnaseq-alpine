#!/bin/bash

readonly RESULTS_DIR_PATH="/work/results/fastp_results/json/"
# fastqファイルのパスを変数に格納
json_file_paths="${RESULTS_DIR_PATH}/*.json"
echo $json_file_paths
for file_path in $json_file_paths; do
    echo $file_path
    # pathからファイル名のみ取り出し、fastpタグをつける
    filename=${file_path##*/}
    filename=${filename/fastp_/}

    mv $file_path ${RESULTS_DIR_PATH}${filename}
done