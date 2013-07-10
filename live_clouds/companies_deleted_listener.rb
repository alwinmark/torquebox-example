require 'live_cloud'
require 'json'

class CompaniesDeletedListener < TorqueBox::Messaging::MessageProcessor

  def on_message(body)
    company = JSON.parse body

    LiveCloud.all(owner: company["id"]).destroy
  end

end
