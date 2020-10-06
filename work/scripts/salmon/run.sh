#!/bin/bash

readonly RESOURCES_DIR_PATH="/work/resources/"
readonly FASTP_RESULTS_DIR_PATH="/work/results/fastp_results/"
readonly SCRIPTS_DIR_PATH="/work/scripts/salmon/"

echo "**** create resources number array ****"
resources_number_array=()
for i in {1..6}
do
    resources_number_array+=("00${i}-${i}")
done
echo "**** resources ****"
echo ${resources_number_array[@]}

mkdir -p ${FASTP_RESULTS_DIR_PATH}

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