# Alpine Linux ベース
FROM alpine:latest
# RUN apt-get update && apt-get install -y \
# sudo \
# wget \
# git
# WORKDIR /opt
# RUN wget https://repo.continuum.io/archive/Anaconda3-2020.07-Linux-x86_64.sh && \
#     sh Anaconda3-2020.07-Linux-x86_64.sh -b -p /opt/anaconda3 && \
#     rm -f Anaconda3-2020.07-Linux-x86_64.sh
# ENV PATH /opt/anaconda3/bin:$PATH
# RUN  pip install --upgrade pip
# WORKDIR /
# RUN conda install -c bioconda -y \
#     fastqc \
#     trimmomatic \
#     megahit \
#     parallel \
#     blast && \ 
#     python3 -m pip install --user --upgrade cutadapt
# RUN git clone https://github.com/LANL-Bioinformatics/FaQCs.git && \
#     cd FaQCs && \
#     make
# ENV PATH /FaQCs:/root/.local/bin:$PATH
# CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--LabApp.token=''"]