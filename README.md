## Public URL

- **Application:** [https://designfiles-invoices-app-0916fa906c57.herokuapp.com/](https://designfiles-invoices-app-0916fa906c57.herokuapp.com/)
- **Letter Opener:** [https://designfiles-invoices-app-0916fa906c57.herokuapp.com/letter_opener/](https://designfiles-invoices-app-0916fa906c57.herokuapp.com/letter_opener/)

# Installation Guide

## Requirements

- **Ruby:** 3.3.5
- **Rails:** 7.21

## Local Setup

1. **Setup and Server:**
    ```bash
    bin/setup
    bin/rails server
    ```

2. **JavaScript Dependencies:**
    ```bash
    npm install
    ```

## Docker Setup

1. **Setup Environment Variables:** Create a `.env` file in the root directory:
    ```env
    DATABASE=your_database_name
    DB_USERNAME=your_username
    DB_PASSWORD=your_password
    DB_HOST=db
    ```

2. **Build the Docker Image:**
    ```bash
    docker-compose build
    ```

3. **Run the Application:**
    ```bash
    docker-compose up
    ```

4. **Access the Application:** Open your browser at [http://localhost:3000](http://localhost:3000).

5. **First Run:** Prepare the database:
    ```bash
    docker-compose run web bin/setup
    ```

## Default Credentials

- **Username:** admin@simple_invoice
- **Password:** simple_invoice

## Steps to Reset Heroku DB

1. Access Heroku console:
    ```bash
    heroku run bash
    ```

2. Truncate the database:
    ```bash
    DISABLE_DATABASE_ENVIRONMENT_CHECK=1 rails db:truncate_all
    ```

3. Run setup:
    ```bash
    bin/setup
    rails db:seed
    ```