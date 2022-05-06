# README

This is demo app for Query Helper library demonstration

## Local setup

```
docker-compose build
docker-compose run api bundle exec rails db:environment:set RAILS_ENV=development
docker-compose run api bundle exec rails db:drop db:create db:schema:load db:seed
docker-compose run api bundle exec rails db:migrate db:seed
docker-compose up
```

## Development

```
docker-compose run api bundle exec rails generate scaffold post title:string body:text --api
docker-compose run api bundle exec rails generate scaffold comment post_id:integer body:text --api
```
