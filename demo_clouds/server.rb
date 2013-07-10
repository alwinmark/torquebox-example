require "demo_cloud"
require "json"

class Server < Sinatra::Base
  use TorqueBox::Session::ServletStore

  get '/' do
    DemoCloud.all.to_json
  end

end
