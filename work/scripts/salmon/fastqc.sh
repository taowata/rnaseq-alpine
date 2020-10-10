#!/bin/bash

readonly RESOURCES_DIR_PATH="/work/resources/"
readonly SCRIPTS_DIR_PATH="/work/scripts/salmon/"
readonly FASTQC_RESULTS_DIR_PATH="/work/results/fastqc_after/"

# 出力先ディレクトリがあるかどうかチェック
if [ -d ${FASTQC_RESULTS_DIR_PATH} ]; then
    echo "fastqc出力用のディレクトリの存在を確認しました。"
else
    echo "fastqc出力用のディレクトリが存在していないため、作成します。"
    mkdir -p ${FASTQC_RESULTS_DIR_PATH}
fi

# fastqファイルを変数に格納
files="${RESOURCES_DIR_PATH}/*.fastq.gz"

# 処理実行
for file in $files; do
    fastqc --threads 4 --nogroup -o $FASTQC_RESULTS_DIR_PATH $file
done