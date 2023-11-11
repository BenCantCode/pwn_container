FROM ubuntu:latest
# USER SETUP
RUN useradd -s /bin/bash -m user -G sudo
# PACKAGES
# apt
RUN apt-get update
RUN apt-get install -y wget
RUN apt-get install -y git 
RUN apt-get install -y python3 
RUN apt-get install -y python3-pip 
RUN apt-get install -y sudo
RUN apt-get install -y gcc
RUN apt-get install -y gdb
RUN apt-get install -y python2
RUN apt-get install -y curl 
RUN apt-get install -y binutils
RUN apt-get install -y patchelf
RUN apt-get install -y nano
RUN apt-get install -y elfutils
RUN apt-get install -y ruby-full
RUN apt-get install -y nasm
RUN apt-get install -y ncat
RUN apt-get install -y tmux
# python
RUN python3 -m pip install pwntools
RUN python3 -m pip install angr
RUN python3 -m pip install ROPgadget
# ruby
RUN gem install one_gadget
# pwninit
WORKDIR /usr/local/bin
RUN wget https://github.com/io12/pwninit/releases/download/3.3.0/pwninit
RUN chmod +x ./pwninit
ADD template.py /home/user/template.py
RUN echo "alias pwninit='pwninit --template-path ~/template.py && chmod 777 solve.py'" >> ~/.bashrc
# sudo setup
RUN echo "user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER user
# pwndbg
WORKDIR /home/user
RUN git clone --depth 1 https://github.com/pwndbg/pwndbg
WORKDIR /home/user/pwndbg
RUN ./setup.sh
# radare2
RUN python3 -m pip install -U r2env r2pipe
RUN ~/.local/bin/r2env add radare2
RUN ~/.local/bin/r2env use radare2@git
RUN ~/.r2env/bin/r2pm -U
ENV PATH="${PATH}:/home/user/.r2env/bin"
RUN ~/.r2env/bin/r2pm -ci r2ghidra
RUN echo 'export PATH="$PATH:/home/user/.r2env/bin"' >> ~/.bashrc
# shell setup
ADD tmux.conf /home/user/.tmux.conf
RUN echo "alias pwninit='pwninit --template-path ~/template.py'" >> ~/.bashrc
RUN echo '[ -z "$TMUX"  ] && { tmux attach || exec tmux new-session && exit;}' >> ~/.bashrc
ADD pwn.conf /home/user/.pwn.conf
WORKDIR /pwn
