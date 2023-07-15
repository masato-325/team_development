FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y \
        build-essential \
        libpq-dev \
        nodejs \
        postgresql-client \
        vim \
        yarn

WORKDIR /team_development

COPY Gemfile Gemfile.lock /team_development/

RUN bundle install
