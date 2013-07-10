require 'company.rb'
require 'credit_card_service'
require 'json'
require 'company_update_service'

class CompanyCreationService

  def self.create(name, creditcard)
    company = Company.create(name: name, credit_card_number: creditcard)
    # I don't know why fetching or injecting does not work
    topic = TorqueBox::Messaging::Topic.new('/topics/companies/created')
    topic.publish company.to_json

    CompanyUpdateService.new.update_credit_card(company.id, creditcard)
    company
  end

end
