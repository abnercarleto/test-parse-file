# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies
```bash
docker-compose build
docker-compose run --rm web bundle install
docker-compose run --rm web yarn install

* Configuration

* Database creation

```bash
docker-compose run --rm web rails db:create
docker-compose run --rm web rails db:migrate
```

* Database initialization

* How to run the test suite
```bash
docker-compose run --rm web rspec
```

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions
```bash
docker-compose run --rm --service-ports web
```

* Acess
http://localhost:3000/
