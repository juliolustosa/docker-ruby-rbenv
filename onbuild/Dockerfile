FROM juliolustosa/ruby-rbenv:latest
MAINTAINER Julio Lustosa "contato@juliolustosa.com.br"

# Copy Gemfile and bundle install
ONBUILD COPY Gemfile $APP_HOME
ONBUILD COPY Gemfile.lock $APP_HOME
ONBUILD RUN bundle install

# Copy app files
ONBUILD COPY . $APP_HOME