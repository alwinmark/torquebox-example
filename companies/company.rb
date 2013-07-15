require 'dm-core'
require 'dm-migrations'
require 'dm-validations'
require 'dm-serializer'

class Company
  include DataMapper::Resource

  STATUS_CREATED = "Created"
  STATUS_CREDITCARD_CHECKING = "Checking"
  STATUS_CREDITCARD_VALID = "Valid"
  STATUS_CREDITCARD_INVALID = "Invalid"

  property :id, Serial
  property :name, String
  property :credit_card_number, String
  property :status, String, default: STATUS_CREATED
end

if ENV['RACK_ENV'] == "development"
  DataMapper::Logger.new($stdout, :debug)
else
  DataMapper::Logger.new($stdout, :error)
end
DataMapper.setup(:default, "sqlite:///tmp/company#{ENV['RACK_ENV'] == "testing"? "_test" : ""}.db")
DataMapper.auto_upgrade!
#DataMapper::Model.raise_on_save_failure = true
