# Use Ruby image
FROM ruby:3.3.5

# Install Node.js
RUN apt-get update -y && \
    apt-get install -y nodejs npm

# Set working directory
WORKDIR /app

# Copy only the Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

# Copy package.json and package-lock.json
COPY package.json package-lock.json ./

# Install JavaScript dependencies
RUN npm install

# Copy application code
COPY . .

# Ensure SQLite storage folder is writable
RUN mkdir -p db && chmod -R 777 db

# Command to run the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]