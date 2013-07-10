require 'company'
require 'json'

class CompanyDeletionService
  include TorqueBox::Injectors

  def self.delete_all(condition = {})
    Company.all(condition).each { |company| delete(company) }
  end

  def self.delete(company)
    topic = TorqueBox::Messaging::Topic.new('/topics/companies/deleted')
    message = company.to_json
    company.destroy
    topic.publish message
  end

end
