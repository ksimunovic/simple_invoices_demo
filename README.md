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
    ```
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
