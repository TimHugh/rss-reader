FROM ruby:2.2.0
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    nodejs

RUN mkdir -p /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle

COPY . ./

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
