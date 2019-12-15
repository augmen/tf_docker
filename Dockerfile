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
# Add NVIDIA package repositories
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-repo-ubuntu1804_10.0.130-1_amd64.deb
RUN dpkg -i cuda-repo-ubuntu1804_10.0.130-1_amd64.deb
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub
RUN apt-get update
RUN wget http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/nvidia-machine-learning-repo-ubuntu1804_1.0.0-1_amd64.deb
RUN apt install ./nvidia-machine-learning-repo-ubuntu1804_1.0.0-1_amd64.deb
RUN apt-get update

# Install NVIDIA driver
RUN apt-get install --no-install-recommends nvidia-driver-418
# Reboot. Check that GPUs are visible using the command: nvidia-smi

# Install development and runtime libraries (~4GB)
RUN apt-get install --no-install-recommends \
    cuda-10-0 \
    libcudnn7=7.6.2.24-1+cuda10.0  \
    libcudnn7-dev=7.6.2.24-1+cuda10.0


# Install TensorRT. Requires that libcudnn7 is installed above.
RUN apt-get install -y --no-install-recommends libnvinfer5=5.1.5-1+cuda10.0 \
    libnvinfer-dev=5.1.5-1+cuda10.0





# clean 
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*
