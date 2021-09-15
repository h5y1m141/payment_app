FROM ruby:2.7.2-alpine AS builder

ENV LC_ALL=C.UTF-8

WORKDIR /app

RUN apk add --update --no-cache \
  build-base \
  git \
  postgresql-dev \
  nodejs \
  yarn \
  tzdata \
  less \
  && gem install --no-document bundler:2.2.6

EXPOSE 3000
CMD ["./bin/rails", "server", "-b", "0.0.0.0", "-p", "3000"]
