FROM ruby:2.4.3-jessie
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y \
	build-essential \
	gsl-bin \
	libgsl0-dev \
	libgsl0ldbl \
	libncurses5-dev \
	libpcap-dev \
	libsctp-dev \
	libssl-dev \
	python \
	python-pip \
	vim

WORKDIR /

ADD https://github.com/SIPp/sipp/releases/download/v3.6.1/sipp-3.6.1.tar.gz /
RUN tar -zxvf sipp-3.6.1.tar.gz

WORKDIR /sipp-3.6.1
RUN ls -l && cmake . -DUSE_GSL=1 -DUSE_PCAP=1 -DUSE_SSL=1 -DUSE_SCTP=1 install
RUN gem install packetfu:1.1.11
RUN git clone https://github.com/mojolingo/sippy_cup.git && cd sippy_cup && bundle install

WORKDIR /
RUN rm -rf sipp-3.6.1.tar.gz sipp-3.6.1
