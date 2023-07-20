ARG RUBY_VERSION
FROM ruby:$RUBY_VERSION-slim-buster

ARG POSTGRES_MAJOR
ARG NODE_MAJOR
ARG BUNDLER_VERSION
ARG YARN_VERSION

# Common dependencies
# node-sassのBuildで失敗するから python2が必要
RUN apt-get update -qq \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
  build-essential \
  gnupg2 \
  curl \
  wget \
  less \
  git \
  unzip \
  python2 \
  openssh-client \
  && apt-get clean \
  && rm -rf /var/cache/apt/archives/* \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && truncate -s 0 /var/log/*log

# Add PostgreSQL to sources list
RUN curl -sSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
  && echo 'deb http://apt.postgresql.org/pub/repos/apt/ buster-pgdg main' $POSTGRES_MAJOR > /etc/apt/sources.list.d/pgdg.list

# Add NodeJS to sources list
RUN curl -sL https://deb.nodesource.com/setup_$NODE_MAJOR.x | bash -

# Add Yarn to the sources list
RUN wget --quiet -O - /tmp/pubkey.gpg https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list


# Install dependencies

RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get -yq dist-upgrade && \
  DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
  libpq-dev \
  postgresql-client-$POSTGRES_MAJOR \
  nodejs \
  yarn=$YARN_VERSION-1 \
  $(cat /tmp/Aptfile | xargs) && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
  truncate -s 0 /var/log/*log

# Configure bundler
ENV LANG=C.UTF-8 \
  BUNDLE_JOBS=4 \
  BUNDLE_RETRY=3

# Upgrade RubyGems and install required Bundler version
RUN gem update --system && \
  gem install bundler:$BUNDLER_VERSION && \
  bundle config set force_ruby_platform true

# 以下のエラーが出るケースあるためprecompiledのやつを避ける
# It looks like you're trying to use Nokogiri as a precompiled native gem on a system with glibc < 2.17:
WORKDIR /home
RUN apt-get update -qq \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
  wget \
  gawk \
  bison \
  tar
RUN wget -c https://ftp.gnu.org/gnu/glibc/glibc-2.29.tar.gz
RUN tar -zxvf glibc-2.29.tar.gz
RUN cd /home/glibc-2.29
RUN ls -al
RUN /home/glibc-2.29/configure --prefix=/opt/glibc
RUN make 
RUN make install

# /lib/aarch64-linux-gnu/libc.so.6 -> libm-2.28.so
# となってるので、上記でソースからコンパイルしてインストール
RUN mv /lib/aarch64-linux-gnu/libm-2.28.so /lib/aarch64-linux-gnu/libm-2.28.so.back
RUN cp /opt/glibc/lib/libm-2.29.so /lib/aarch64-linux-gnu/libm-2.28.so

RUN gem install nokogiri --platform=ruby -v 1.13.8
# Create a directory for the app code
RUN mkdir -p /app

WORKDIR /app

EXPOSE 3000

