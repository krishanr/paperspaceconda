# ------------- ALL THIS REQUIRED FOR PAPERSPACE -------------
FROM python:3.9.10

ENV APP_HOME /
WORKDIR $APP_HOME

# Install base utilities
RUN apt-get update && \
    # apt-get install -y build-essentials  && \
    apt-get install -y wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install miniconda
ENV CONDA_DIR /opt/conda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda

# Put conda in path so we can use conda activate
ENV PATH=$CONDA_DIR/bin:$PATH

# ------------- FROM HERE ON IS MY ANCONDA ENVIRONMENT SETUP -------------
RUN pip install -U pip -qqq

ADD environment.yml $APP_HOME/environment.yml
RUN conda env create -f $APP_HOME/environment.yml

ENV PATH $CONDA_DIR/envs/tf2/bin:$PATH
RUN echo "source activate tf2" > ~/.bashrc