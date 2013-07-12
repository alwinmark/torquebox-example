require 'json'
require 'company'
require 'company_update_service'

class CompanyReplayService

  def self.replay companies
    check_unchecked_creditcards companies

    topic = TorqueBox::Messaging::Topic.new('/topics/companies/replay')
    topic.publish companies.to_json
  end

  def self.check_unchecked_creditcards companies
    unchecked = companies.select { |company| company.status == Company::STATUS_CREDITCARD_CHECKING }
    unchecked.each do |company|
      CompanyUpdateService.update_credit_card(company.id, company.credit_card_number)
    end
  end
end
