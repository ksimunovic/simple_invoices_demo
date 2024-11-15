# Installation

## Requirements

- Ruby: 3.3.5
- Rails: 7.21

## Setup and Server

Run the following commands to set up and start the server:

```bash
bin/setup
bin/rails server
```

## JavaScript Dependencies

To install JavaScript dependencies, execute:

```bash
npm install
```

## Docker Instructions

Build and run the application with Docker:

```bash
docker build -t designfiles_invoices_app .
docker run -p 3000:3000 designfiles_invoices_app
``` 