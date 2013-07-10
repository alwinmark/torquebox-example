require 'dm-core'
require 'dm-migrations'
require 'dm-validations'
require 'dm-serializer'

class DemoCloud
  include DataMapper::Resource

  property :id, Serial
  property :owner, Integer
end

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, "sqlite:///tmp/demo_cloud.db")
DataMapper.auto_upgrade!
