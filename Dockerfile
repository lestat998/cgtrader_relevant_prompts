FROM ruby:3.2.2

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

WORKDIR /app

COPY ./Gemfile ./Gemfile.lock ./
RUN gem install bundler
RUN bundle install

# Copy the main application
COPY . /app

# Expose the port the app runs on
EXPOSE 3000

# Start the application using Foreman
CMD ["./up.sh"]