# docker build -t dleongsh/torchaudio:0.11.0 .
FROM pytorch/pytorch:1.11.0-cuda11.3-cudnn8-runtime

# install necessary packages
RUN apt-get -y update && apt-get install -y ca-certificates curl gcc build-essential wget git libsndfile1 sox ffmpeg \
&& rm -rf /var/lib/apt/lists/*

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE 1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED 1

# Add requirements and reinstall torch to required version
RUN pip3 install --upgrade --no-cache pip

ADD requirements.txt .
RUN python3 -m pip install --no-cache-dir -r requirements.txt
RUN python3 -m pip install --no-cache-dir torchaudio==0.11.0 --extra-index-url https://download.pytorch.org/whl/cu113

WORKDIR "/workspace"

#docker container starts with bash
RUN ["bash"]