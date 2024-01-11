FROM ruby:3.2.2

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

WORKDIR /app

COPY ./Gemfile ./Gemfile.lock ./
RUN gem install bundler --no-document
RUN bundle install --no-binstubs --jobs $(nproc) --retry 3 --without development test

# Copy the main application
COPY . /app

# Expose the port the app runs on
EXPOSE 3000

# Start the application using Foreman
CMD ["./up.sh"]