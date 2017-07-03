FROM juliolustosa/ubuntu:16.04
MAINTAINER Julio Lustosa "contato@juliolustosa.com.br"

# Set an environment variable
ENV RUBY_VERSIONS "2.4.1, 2.3.4"
ENV RUBY_VERSION_DEFAULT 2.3.4
ENV USER deploy
ENV APP_HOME /app
ENV DEBIAN_FRONTEND noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    libffi-dev \
    zlib1g-dev \
    libssl-dev \
    libreadline-dev \
    libyaml-dev \
    libpq-dev \
    libmysqlclient-dev \
    libsqlite3-dev \
    sqlite3 \
    libxml2-dev \
    libxslt1-dev \
    libgdbm-dev \
    libncurses5-dev \
    libcurl4-openssl-dev \
    libffi-dev \
    nodejs \
    npm

# Upgrade old packages
RUN apt-get upgrade -y -o Dpkg::Options::="--force-confold"

# Copy scripts
RUN mkdir -p ./build-scripts
COPY ./build-scripts /build-scripts
RUN chmod +x /build-scripts/*.sh

# Install
RUN /build-scripts/install.sh

# Create App Home
RUN mkdir -p $APP_HOME
RUN chown $USER:$USER $APP_HOME

# Install RBENV
USER $USER
RUN /build-scripts/rbenv.sh

# Clear all
USER root
RUN /build-scripts/clear.sh

# Set new user
USER $USER

# Set workdir
WORKDIR $APP_HOME

# Fix environment variable
ENV RBENV_ROOT /home/$USER/.rbenv
ENV PATH="$RBENV_ROOT/bin:$RBENV_ROOT/shims:$PATH"
ENV PATH="$RBENV_ROOT/plugins/ruby-build/bin:$PATH"

## Gems
RUN gem install bundler && rbenv rehash
RUN gem install rake && rbenv rehash

CMD [ "irb" ]