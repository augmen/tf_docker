FROM tensorflow/tensorflow:latest-gpu-py3

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# install packages
RUN apt-get -y update --fix-missing && \
    apt-get install -y \
	apt-utils \
	build-essential \
	bzip2 \
	cmake \
	curl \
	git \
	libmecab-dev \
	libc6-dev \
	libssl-dev \
	libreadline-dev \
	libssl-dev \
	libsm6 \
	libxrender1 \
	mecab \
	mecab-ipadic \
	mecab-ipadic-utf8 \
	net-tools \
	python3-pip \
	software-properties-common \
	sudo \
	unzip \
	vim \
	wget \
	zlib1g-dev

# install pip packages
RUN pip install --upgrade pip 
RUN pip install \
	numpy \
        pandas \
        matplotlib \
        seaborn \
        flask \
        tensorflow-gpu \
        datetime \
        tqdm \
        schedule \
        alpha_vantage \
	gensim \
	google_images_download \
	janome \
	keras \
	mecab-python3 \
	opencv-python \
	openpyxl \
	pyyaml \
	requests \
	scikit-learn \
	scikit-image \
	tinydb \
	xlrd

# reinstall tensorflow because of gpu support
RUN pip uninstall -y tensorflow tensorflow-gpu
RUN pip install tensorflow-gpu

# Install CUDA
RUN distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
RUN curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
RUN curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

RUN sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit
RUN sudo systemctl restart docker 
# Check docker NVIDIA
RUN lspci | grep -i nvidia


# clean 
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*
