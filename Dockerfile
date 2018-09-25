FROM ruby:2.4.3-jessie AS build

RUN gem install packetfu:1.1.11
RUN git clone https://github.com/mojolingo/sippy_cup.git && cd sippy_cup && bundle install

FROM ruby:2.4.3-alpine
RUN apk update && apk add sipp

COPY --from=build /usr/local/bundle/ /usr/local/bundle/
