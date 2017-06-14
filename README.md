# Air-Attack sample app

This is simple skinny rails app in (json api only mode) to show how to rate limit requests and test em with rspec.

## Basic

### Functionality

* Return `OK`

### Limitations

* 100 requests per hour / could be changed

* This is implementations using Redis and is suitable for clustered app.
* Make sure that you never use rate limit for API using ruby. Go safer way with proper API Gateway solitions.


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

If you Redis is not running the app will ignore that while frendly notifying about that in a console
![RED notification](screenshots/dead_redis.png?raw=true)

## License

Air-Attack is freely distributable under the
terms of an MIT-style [licence](https://github.com/noma4i/air-attack/blob/master/licence.txt).

Copyright notice and permission notice shall be included in all
copies or substantial portions of the Software.
