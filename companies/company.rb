require 'dm-core'
require 'dm-migrations'
require 'dm-validations'
require 'dm-serializer'

class Company
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :credit_card_number, String
  property :status, String, default: "Checking"

  STATUS_CREDITCARD_CHECKING = "Checking"
  STATUS_CREDITCARD_VALID = "Valid"
  STATUS_CREDITCARD_INVALID = "Invalid"

end

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, "sqlite:///tmp/company.db")
DataMapper.auto_upgrade!
#DataMapper::Model.raise_on_save_failure = true
