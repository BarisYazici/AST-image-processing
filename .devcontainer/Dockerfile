FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

ARG USER_UID=1001
ARG USER_GID=1001
ARG USERNAME=user

WORKDIR /workspaces
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && mkdir -p -m 0700 /run/user/"${USER_UID}" \
    && mkdir -p -m 0700 /run/user/"${USER_UID}"/gdm \
    && chown user:user /run/user/"${USER_UID}" \
    && chown user:user /workspaces \
    && chown user:user /run/user/"${USER_UID}"/gdm \
    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

ENV XDG_RUNTIME_DIR=/run/user/"${USER_UID}"

ENV TZ=Europe/Paris
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update

# Essential packages
RUN apt-get install -y apt-utils build-essential unzip git

# ASTimp dependencies
RUN apt-get install -y libopencv-dev cmake libgtest-dev

# clone astimp and compile it
# RUN cd home
# RUN git clone https://github.com/mpascucci/AST-image-processing.git /home/AST-image-processing
# RUN /workspaces/src/run-build.sh

# Install Python wrapper module and Juputer
# RUN apt-get install -y python3-pip python3-opencv
# RUN pip3 install jupyterlab
# RUN cd /workspaces/src/python-module/ && ./install_astimp_python_module.sh
# RUN echo LD_LIBRARY_PATH=/workspaces/src/build/astimplib:$LD_LIBRARY_PATH >> /home/user/.bashrc
# RUN unzip "/workspaces/src/python-module/jupyter-lab-example/ASTimp Quick Start with python.zip"
COPY ../entrypoint.sh /workspaces/src/
ENTRYPOINT [ "/workspaces/src/entrypoint.sh" ]

# ENTRYPOINT ["/workspaces/src/entrypoint.sh"]
# set the default user to the newly created user
USER $USERNAME