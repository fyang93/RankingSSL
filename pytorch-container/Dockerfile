FROM pytorch/pytorch:1.13.1-cuda11.6-cudnn8-devel

ARG USERNAME
ARG USER_UID
ARG USER_GID=$USER_UID

ENV HOME /home/$USERNAME
ENV SHELL /bin/bash
ENV DEBIAN_FRONTEND=noninteractive

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y sudo curl wget git tmux libglib2.0-0 libsm6 libxrender1 libxext6 libgl1-mesa-dev \
    && rm -rf /var/lib/apt/lists/* \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

ENV DEBIAN_FRONTEND=

USER $USERNAME
WORKDIR $HOME

COPY ./requirements.txt /tmp/
RUN pip install --upgrade pip \
    && pip install --user --no-cache-dir -r /tmp/requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple