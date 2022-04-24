FROM ubuntu

RUN apt update && apt install -y make conky
COPY . /tmp/cwmanager
WORKDIR /tmp/cwmanager
RUN bash configure.sh && make install
WORKDIR /root

ENTRYPOINT /bin/bash

# Just for test.