#!/bin/bash
readonly RESOURCES_DIR_PATH="/work/resources/"
readonly RESULTS_DIR_PATH="/work/results/"

stringtie ${RESULTS_DIR_PATH}bam_result/sort1.bam -o ${RESULTS_DIR_PATH}stringtie_result/stringtie_result1.gtf -G ${RESOURCES_DIR_PATH}IRGSP-1.0_representative_transcript_exon_2020-09-09.gtf -A ${RESULTS_DIR_PATH}stringtie_result/stringtie_result1.tab