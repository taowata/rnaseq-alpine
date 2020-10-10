#!/bin/bash

readonly RESULTS_DIR_PATH="/work/results/fastp_results/"
# fastqファイルのパスを変数に格納
html_file_paths="${RESULTS_DIR_PATH}/*.html"

for file_path in $html_file_paths; do
    echo $file_path
    # pathからファイル名のみ取り出す
    filename=${file_path##*/}

    mv $file_path "${RESULTS_DIR_PATH}html/fastp_${filename}"
done