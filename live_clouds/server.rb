require "live_cloud"
require "json"

class Server < Sinatra::Base
  use TorqueBox::Session::ServletStore

  get '/' do
    LiveCloud.all.to_json
  end

end
