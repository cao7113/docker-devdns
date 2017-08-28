FROM ruby:2.4-alpine
MAINTAINER Ruijian Cao <cao7113@hotmail.com>
RUN apk update && apk add build-base
RUN mkdir /app
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle install --binstubs --verbose
COPY devdns.rb ./
CMD bundle exec ./devdns.rb
