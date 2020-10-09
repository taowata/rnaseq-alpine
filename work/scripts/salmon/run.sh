#!/bin/bash

readonly RESOURCES_DIR_PATH="/work/resources/"
readonly RESULTS_DIR_PATH="/work/results/"
readonly SCRIPTS_DIR_PATH="/work/scripts/salmon/"

# FastQCで最初のクオリティチェック
# fastq file's directory
files="${RESOURCES_DIR_PATH}/*.fastq.gz"
# 出力先のディレクトリを作成 
mkdir -p "${RESULTS_DIR_PATH}fastqc/"

for file in $files; do
    fastqc --threads 4 --nogroup -o "${RESULTS_DIR_PATH}fastqc/" $file
done

# fastpで前処理
readonly FASTP_RESULTS_DIR_PATH="${RESULTS_DIR_PATH}fastp_results/"
# 出力先ディレクトリがあるかどうかチェック
if [ -d ${FASTP_RESULTS_DIR_PATH} ]; then
    echo "fastp出力用のディレクトリがすでに存在しています。"
else
    echo "fastp出力用のディレクトリが存在していないため、作成します。"
    mkdir -p ${FASTP_RESULTS_DIR_PATH}
fi

for value in ${resources_number_array[@]}
do
    echo "**** now preproccessing sample: ${value} ****"
    fastp \
    -i "resources/TY${value}_combined_R1.fastq.gz" \
    -I "resources/TY${value}_combined_R2.fastq.gz" \
    -3 \
    -o "${FASTP_RESULTS_DIR_PATH}fastp_${value}_R1.fq.gz" \
    -O "${FASTP_RESULTS_DIR_PATH}fastp_${value}_R2.fq.gz" \
    -h "${FASTP_RESULTS_DIR_PATH}trimreport_${value}_fastp.html" \
    -j "${FASTP_RESULTS_DIR_PATH}trimreport_${value}_fastp.json" \
    -q 15 \
    -n 10 \
    -t 1 \
    -T 1 \
    -l 20 \
    -w 6
    echo "**** finish preproccess of sample: ${value} ****"
done

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
    salmon quant \
    -i "${RESOURCES_DIR_PATH}transcripts_index_salmon" \
    -p 6 \
    -l A \
    -1 "${FASTP_RESULTS_DIR_PATH}fastp_${value}_R1.fq.gz" \
    -2 "${FASTP_RESULTS_DIR_PATH}fastp_${value}_R2.fq.gz" \
    --validateMappings \
    -o "${SALMON_RESULTS_DIR_PATH}salmon_output_${value}"
done

# 総合的なレポート出力
multiqc .