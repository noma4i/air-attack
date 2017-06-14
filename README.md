# Air-Attack sample app

This is simple skinny rails app in (json api only mode) to show how to rate limit requests and test em with rspec.

## Requirements

* Ruby `>= 2.2.2` minimum requirement comes from rails 5.1
* Redis `>= 2.0`

## Configuration

User `.env` or `.env.local` to configure connection to redis
This app comes pre-configured but you can change rule in `rate-limit.yml`

## Functionality

* Return `OK`

## Limitations

* 100 requests per hour / could be changed

* This is implementations using Redis and is suitable for clustered app.
* Make sure that you never user rate limit for API using ruby. Go safer way with proper API Gateway solitions.