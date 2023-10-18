FROM ruby:3.2.2-slim-bullseye as base

RUN apt-get update -qq && apt-get install -y build-essential apt-utils libpq-dev nodejs postgresql-client

ARG APP_NAME

WORKDIR "/${APP_NAME}"

COPY Gemfile ./
COPY Gemfile.lock ./

RUN gem install bundler
RUN bundle install

ADD . /"${APP_NAME}"


COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

ARG DEFAULT_PORT 3000

EXPOSE ${DEFAULT_PORT}
