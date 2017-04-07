FROM ruby:latest
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y \
	build-essential \
	libncurses5-dev \
	libpcap-dev \
	libsctp-dev \
	libssl-dev

WORKDIR /

ADD https://github.com/SIPp/sipp/releases/download/v3.5.1/sipp-3.5.1.tar.gz /
RUN tar -zxvf sipp-3.5.1.tar.gz

WORKDIR /sipp-3.5.1
RUN ls -l && ./configure --with-pcap --with-sctp --with-openssl --with-rtpstream && make install
RUN gem install sippy_cup

WORKDIR /
RUN rm -rf v3.4.1.tar sipp-3.4.1

# Can run on the SBC: docker run -v /tls:/tls -p 80:8080 585902692734.dkr.ecr.us-east-1.amazonaws.com/sipp:master
