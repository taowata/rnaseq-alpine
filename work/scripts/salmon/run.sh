#!/bin/bash

readonly RESOURCES_DIR_PATH="/work/resources/"
readonly RESULTS_DIR_PATH="/work/results/"
readonly SCRIPTS_DIR_PATH="/work/scripts/salmon/"

# FastQCで最初のクオリティチェック
readonly FASTQC_RESULTS_DIR_PATH="${RESULTS_DIR_PATH}fastqc/"

# 出力先のディレクトリを作成 
mkdir -p "${RESULTS_DIR_PATH}fastqc/"

# 出力先ディレクトリがあるかどうかチェック
if [ -d ${FASTQC_RESULTS_DIR_PATH} ]; then
    echo "fastqc出力用のディレクトリがすでに存在しています。"
else
    echo "fastqc出力用のディレクトリが存在していないため、作成します。"
    mkdir -p ${FASTQC_RESULTS_DIR_PATH}
fi

# fastqファイルを変数に格納
files="${RESOURCES_DIR_PATH}/*.fastq.gz"

for file in $files; do
    fastqc --threads 4 --nogroup -o $FASTQC_RESULTS_DIR_PATH $file
done

echo "*****fastqc finished*****"

echo "*****fastp starts*****"
# fastpで前処理
readonly FASTP_RESOURCE_DIR_PATH="${RESOURCES_DIR_PATH}fastp_resources/"
readonly FASTP_RESULTS_DIR_PATH="${RESULTS_DIR_PATH}fastp_results/"

# 出力先ディレクトリがあるかどうかチェック、なければ作成
if [ -d ${FASTP_RESULTS_DIR_PATH} ]; then
    echo "fastp出力用のディレクトリがすでに存在しています。"
else
    echo "fastp出力用のディレクトリが存在していないため、作成します。"
    mkdir -p ${FASTP_RESULTS_DIR_PATH}
fi

# fastqファイルをread1, read2ごとに分けて格納
files_1="${FASTP_RESOURCE_DIR_PATH}*R1*"
files_2="${FASTP_RESOURCE_DIR_PATH}*R2*"

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
    # 出力ファイル名を作る
    read1_filepath=${read1_paths[$i]}
    read1_filename=${read1_filepath##*/}
    read1_output=${FASTP_RESULTS_DIR_PATH}${read1_filename/.fastq.gz/_trimmed.fastq.gz}

    read2_filepath=${read2_paths[$i]}
    read2_filename=${read2_filepath##*/}
    read2_output=${FASTP_RESULTS_DIR_PATH}${read2_filename/.fastq.gz/_trimmed.fastq.gz}

    html=${FASTP_RESULTS_DIR_PATH}${read1_filename/R1.fastq.gz/fastp.html}
    json=${FASTP_RESULTS_DIR_PATH}${read1_filename/R1.fastq.gz/fastp.json}

    fastp -i ${read1_paths[$i]} -I ${read2_paths[$i]} -o $read1_output -O $read2_output \
    -h $html -j $json --trim_poly_x -q 20 -l 20 --thread 4
    rm ${read1_paths[$i]} ${read2_paths[$i]}
done

echo "*****fastp finished*****"

echo "*****salmon starts*****"
# salmonでリードカウント
readonly SALMON_RESULTS_DIR_PATH="${RESULTS_DIR_PATH}salmon_results/"
# 出力先ディレクトリがあるかどうかチェック
if [ -d ${SALMON_RESULTS_DIR_PATH} ]; then
    echo "salmon出力用のディレクトリがすでに存在しています。"
else 
    echo "salmon出力用のディレクトリが存在していないため、作成します。"
    mkdir -p ${SALMON_RESULTS_DIR_PATH}
fi

for value in ${resources_number_array[@]}
do
    echo "**** quantify sample: ${value} ****"
    salmon quant -i "${RESOURCES_DIR_PATH}transcripts_index_salmon" \
    -p 4 -l A \
    -1 "${FASTP_RESULTS_DIR_PATH}fastp_${value}_R1.fq.gz" \
    -2 "${FASTP_RESULTS_DIR_PATH}fastp_${value}_R2.fq.gz" \
    --validateMappings \
    -o "${SALMON_RESULTS_DIR_PATH}salmon_output_${value}"
done

# 総合的なレポート出力
multiqc .