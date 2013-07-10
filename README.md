This is a solution for https://github.adcloud.com/gist/256 written in Ruby and used Torquebox with Sinatra and DataMapper

## Install

* rbenv install jruby-1.7.3

 *  if this does not work, update your ruby-build by `cd [RBENVPATH]/plugins/ruby-build && git pull`

* `rbenv local jruby-1.7.3`
* `gem install bundler`
* `bundle install`
* `./deploy`
* `bundle exec torquebox run`


## Usage

### Companies
* show all companies: `GET http://localhost:8080/companies/`
* create a company: `POST http://localhost:8080/companies/?name=[yourname]&credit_card_number=[number with a even last digit are valid]`
* delete a company: `DELETE http://localhost:8080/companies/[id]`
* delete all companies: `DELETE http://localhost:8080/companies/all`
* replay (is used to sync data between cosumers and companies): `GET http://localhost:8080/companies/replay`

### Demo and Live Clouds

* show all: `GET http://localhost:8080/[demo|live]_clouds/`


## TODO

writing Tests
