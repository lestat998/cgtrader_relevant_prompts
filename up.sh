#!/usr/bin/env bash

rm -rf tmp/pids/server.pid

# Run database migrations
bundle exec rails db:migrate

# Start Foreman
bundle exec foreman start
