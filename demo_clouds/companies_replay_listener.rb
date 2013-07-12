require 'json'
require 'replay_service'

class CompaniesReplayListener < TorqueBox::Messaging::MessageProcessor

  def on_message(body)
    companies = JSON.parse body

    ReplayService.replay companies
  end
end
