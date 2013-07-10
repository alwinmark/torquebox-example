require 'company.rb'
require 'json'

class CompanyCreationService
  include TorqueBox::Messaging::Backgroundable
  include TorqueBox::Injectors

  always_background :check_credit_card

  def self.create(name, creditcard)
    company = Company.create(name: name, credit_card_number: creditcard)
    # I don't know why fetching or injecting does not work
    topic = TorqueBox::Messaging::Topic.new('/topics/companies/created')
    topic.publish company.to_json
    self.new().check_credit_card(company.id, creditcard)
    company
  end

  def check_credit_card(company_id, creditcard)
    company = Company.get(company_id)
    company.update(status: (valid_credit_card?(creditcard) ? Company::STATUS_CREDITCARD_VALID : Company::STATUS_CREDITCARD_INVALID))
    # I don't know why fetching or injecting does not work
    topic = TorqueBox::Messaging::Topic.new('/topics/companies/status_changed')
    topic.publish company.to_json
    true
    rescue Exception => e
      puts "Sth. went wrong: #{e.message}"
  end

  def valid_credit_card?(creditcard)
    sleep 7 #maybe some network delay to creditcard service
    creditcard[-1,1].to_i.even?
  end
end
