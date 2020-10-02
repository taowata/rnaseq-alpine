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
    conda update --all -y && \
    conda config --set auto_update_conda False && \
    conda clean --all -y

RUN echo "**** install analysis tools ****" && \
    conda install -c bioconda -y \
    trim-galore \
    hisat2 \
    samtools \
    stringtie \
    deeptools && \
    \
    cd "${CONDA_DIR}/lib" && \
    ln -s libcrypto.so.1.1 libcrypto.so.1.0.0 && \
    \
    pip install multiqc
CMD ["/bin/ash"]