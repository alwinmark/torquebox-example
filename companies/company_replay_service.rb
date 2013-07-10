require 'json'
require 'company'

class CompanyReplayService

  def self.replay companies
    topic = TorqueBox::Messaging::Topic.new('/topics/companies/replay')
    topic.publish companies.to_json
  end

end
