FROM ruby:3.0.0

RUN apt-get update -qq && \
    apt-get install -y \
            nodejs \
            postgresql-client

RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install -y yarn

RUN apt-get install -y cron

RUN mkdir /riko_volley

ENV APP_ROOT /riko_volley
WORKDIR $APP_ROOT

ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

RUN bundle install
ADD . $APP_ROOT

RUN bundle exec whenever --update-crontab
CMD ["cron", "-f"]