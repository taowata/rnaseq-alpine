# from the image based on Alpine Linux image and contains glibc to enable Miniconda
FROM frolvlad/alpine-glibc:alpine-3.12

# Inspired by :
# * https://github.com/Docker-Hub-frolvlad/docker-alpine-miniconda3
# * https://github.com/datarevenue-berlin/alpine-miniconda

ARG CONDA_VERSION="4.7.12.1"
ARG CONDA_DIR="/opt/conda"

ENV PATH="$CONDA_DIR/bin:$PATH"

# Install conda
RUN echo "**** install dev packages ****" && \
    apk add bash wget && \
    \
    echo "**** get Miniconda ****" && \
    mkdir -p "$CONDA_DIR" && \
    wget "http://repo.continuum.io/miniconda/Miniconda3-${CONDA_VERSION}-Linux-x86_64.sh" -O miniconda.sh && \
    \
    echo "**** install Miniconda ****" && \
    bash miniconda.sh -f -b -p "$CONDA_DIR" && \
    rm miniconda.sh && \
    \
    echo "**** setup Miniconda ****" && \
    conda update --all --yes

CMD ["/bin/ash"]
    # conda update --all --yes && \
    # echo "export PATH=$CONDA_DIR/bin:\$PATH" > /etc/profile.d/conda.sh && \
    # \
    # echo "**** setup Miniconda ****" && \
    # conda update --all --yes && \
    # conda config --set auto_update_conda False && \
    # \
    # echo "**** cleanup ****" && \
    # apk del --purge .build-dependencies && \
    # rm -f miniconda.sh && \
    # conda clean --all --force-pkgs-dirs --yes && \
    # find "$CONDA_DIR" -follow -type f \( -iname '*.a' -o -iname '*.pyc' -o -iname '*.js.map' \) -delete && \
    # \
    # echo "**** finalize ****" && \
    # mkdir -p "$CONDA_DIR/locks" && \
    # chmod 777 "$CONDA_DIR/locks"
# Alpine Linux ベース
# FROM alpine:3.12.0
# RUN apk update && \
#     apk add wget bash
# RUN mkdir -p opt/conda
# RUN wget "http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh" -O miniconda.sh

# CMD ["/bin/ash"]



# RUN apt-get update && apt-get install -y \
# sudo 
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