require "demo_cloud"
require "json"
require "replay_service"

class Server < Sinatra::Base
  use TorqueBox::Session::ServletStore

  get '/' do
    DemoCloud.all.to_json
  end

  get '/replay' do
    ReplayService.replay
  end

end
