#!/bin/bash

readonly RESOURCES_DIR_PATH="/work/resources/"
readonly RESULTS_DIR_PATH="/work/results/"
readonly SCRIPTS_DIR_PATH="/work/scripts/salmon/"
readonly SALMON_RESULTS_DIR_PATH="${RESULTS_DIR_PATH}salmon_results/"

# 出力先ディレクトリがあるかどうかチェック
if [ -d ${SALMON_RESULTS_DIR_PATH} ]; then
    echo "salmon出力用のディレクトリがすでに存在しています。"
else 
    echo "salmon出力用のディレクトリが存在していないため、作成します。"
    mkdir -p ${SALMON_RESULTS_DIR_PATH}
fi

# fastqファイルをread1, read2ごとに分けて格納
files_1="${RESOURCES_DIR_PATH}*R1*"
files_2="${RESOURCES_DIR_PATH}*R2*"

# ファイルパスを配列として再定義
read1_paths=()
for filepath in $files_1; do
  read1_paths+=("$filepath")
done

read2_paths=()
for filepath in $files_2; do
  read2_paths+=("$filepath")
done

# 配列の要素数-1を取得
iteration=`expr  ${#read1_paths[@]} - 1`

for i in $(seq 0 ${iteration}); do
    # ファイルパスを取り出す
    read1_filepath=${read1_paths[$i]}
    read2_filepath=${read2_paths[$i]}

    salmon quant -i "${RESOURCES_DIR_PATH}transcripts_index_salmon" \
    -p 4 -l A -1 $read1_filepath -2 $read2_filepath --validateMappings \
    -o "${SALMON_RESULTS_DIR_PATH}salmon_output_${i+1}"
done
