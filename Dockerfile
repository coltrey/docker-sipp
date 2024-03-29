FROM ruby:3.1.2-bullseye
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y \
        awscli \
        build-essential \
        cmake \
        gsl-bin \
        libgsl25 \
        libgslcblas0 \
        libgsl0-dev \
        libncurses5-dev \
        libpcap-dev \
        libsctp-dev \
        libssl-dev \
        python3 \
        python3-pip \
        vim

WORKDIR /

ADD https://github.com/SIPp/sipp/releases/download/v3.7.2/sipp-3.7.2.tar.gz /
RUN tar -zxvf sipp-3.7.2.tar.gz

WORKDIR /sipp-3.7.2
RUN ls -l && ./build.sh --full && make install
RUN gem install packetfu:1.1.11
RUN git clone https://github.com/mojolingo/sippy_cup.git && cd sippy_cup && bundle install

WORKDIR /
RUN rm -rf sipp-3.7.2.tar.gz sipp-3.7.2
