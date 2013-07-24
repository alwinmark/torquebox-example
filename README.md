This is a solution for https://github.adcloud.com/gist/256 written in Ruby and used Torquebox with Sinatra and DataMapper

## Install

* rbenv install jruby-1.7.3

 *  if this does not work, update your ruby-build by `cd [RBENVPATH]/plugins/ruby-build && git pull`

* `rbenv local jruby-1.7.3`
* `gem install bundler`
* `bundle install`
* `./deploy`
* `bundle exec torquebox run`

### Startup tuning

* `export JAVA\_OPTS="-d32"`
* more things can be found here: http://blog.headius.com/2010/03/jruby-startup-time-tips.html

## Testing

you can run tests with:
* All Tests: `be rspec` or `be rake spec`
* Only unit tests: `be rspec spec/unit` or `be rake spec unit`
* Only integration tests: `be rspec spec/integration` or `be rake spec integration`
* only one test: `be rspec [PATH OF YOUR TESTFILE]`

!Note! You find outPUTS from remote\_describes in your torquebox/jboss logs. To find out the path you can deploy an app.

### Guard

run Guard with `be guard`.

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

[] writing Tests for live\_clouds
[] writing Tests for demo\_clouds
[] better file structure for the apps. (Without any configuration every Background job and Message listener has to be in the application Root)
