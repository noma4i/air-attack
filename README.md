# Air-Attack sample app

This is simple skinny rails app in (json api only mode) to show how to rate limit requests and test em with rspec.

# Why

![RED notification](screenshots/challenge_description.png?raw=true)

Time between reviews ~10 days.

# First attempt

Done with `rack-attack`
Result: ** ASKED NOT TO USE GEMS **

# Second attempt

Dead simple middleware.
Result: *pending*

## Basic

### Functionality

* Return `OK`

### Limitations & Thoughts

* 100 requests per hour / could be changed
* This is implementations using Redis and is suitable for clustered app.
* Make sure that you never use rate limit for API using ruby. [Go safer way with proper API Gateway solitions](https://www.nginx.com/blog/microservices-api-gateways-part-1-why-an-api-gateway).


### Requirements

* Ruby `>= 2.2.2` minimum requirement comes from rails 5.1
* Redis `>= 2.0`

or

* docker

### Configuration

User `.env` or `.env.local` to configure connection to redis
This app comes pre-configured but you can change rule in `rate-limit.yml`

### How to run?

for development `bundle install` and `rails server`

or

`docker-compose up` - will run in production mode

### Testing

do `bundle exec rspec`

## Caveats

If you Redis is not up and running the app will ignore that while friendly giving blody r
![RED notification](screenshots/dead_redis.png?raw=true)

## License

Air-Attack is freely distributable under the
terms of an MIT-style [licence](https://github.com/noma4i/air-attack/blob/master/licence.txt).

Copyright notice and permission notice shall be included in all
copies or substantial portions of the Software.
