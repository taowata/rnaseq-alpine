#!/bin/bash

result_files_array=()
for i in {1..5}
do
    result_files_array+=("00${i}-${i}")
done

for v in ${result_files_array[@]}
do
    mv "/work/results/fastp_results/trimreport_${v}.html" "/work/results/fastp_results/trimreport_${v}_fastp.html"
    mv "/work/results/fastp_results/report_${v}.json" "/work/results/fastp_results/trimreport_${v}_fastp.json"
done