# copyright 2017-2018 Regents of the University of California and the Broad Institute. All rights reserved.
FROM python:3.8-buster

MAINTAINER Anthony Castanza <acastanza@cloud.ucsd.edu>

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

RUN mkdir /src

# install system dependencies
RUN apt-get update --yes
RUN apt-get install build-essential --yes
RUN apt-get install libcurl4-gnutls-dev --yes
RUN apt-get install libhdf5-serial-dev --yes
# RUN apt-get install libigraph0-dev --yes #This should install automatically with python-igraph as the repo version fails
RUN apt-get install libxml2-dev --yes

# install python with conda
RUN mkdir /conda && \
    cd /conda && \
    wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda
ENV PATH="/opt/conda/bin:${PATH}"

# install R dependencies

# install python dependencies
RUN pip install numpy==1.19.2
RUN pip install pandas==1.2.2
RUN pip install scipy==1.5.3
RUN pip install anndata==0.7.5
RUN pip install python-igraph==0.8.2
RUN pip install louvain==0.7.0
RUN pip install scanpy==1.7
RUN pip install cmake==3.18.4
RUN pip install MulticoreTSNE==0.1
RUN pip install loompy==3.0.6
RUN pip install scvelo==0.2.3

# copy module files
COPY src/* /src/
RUN chmod a+x /src/compute_scvelo.py

# display software versions
RUN python --version
RUN pip --version

# default command
CMD ["python --version"]