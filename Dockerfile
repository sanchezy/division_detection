FROM conda/miniconda2

# System packages
RUN apt-get update && apt-get install -y curl git gcc

RUN conda install -y ipython tensorflow matplotlib
RUN conda install -y -c ilastik pyklb
RUN conda install -y -c conda-forge pathos

# create expected dirs, symlink for extra robustness
WORKDIR /results
RUN ln -s /results ~/results && \
    ln -s /var/log ~/logs


# install augment
RUN pip install git+https://github.com/funkey/augment.git

WORKDIR /research

ADD . /research/division_detection

RUN pip install -e division_detection/

CMD bash