require 'company'
require 'credit_card_service'
require 'json'

class CompanyUpdateService
  include TorqueBox::Messaging::Backgroundable

  always_background :update_credit_card

  def self.update(id, values)
    company = Company.get(id)
    company.update(name: values[:name])
    if values.keys.include? :credit_card_number
      self.update_credit_card(id, values[:credit_card_number])
    end
  end

  def self.update_credit_card(id, creditcard)
    company = Company.get(id)
    company.update(status: Company::STATUS_CREDITCARD_CHECKING)

    company.update(status: (CreditCardService.valid_credit_card?(creditcard) ? Company::STATUS_CREDITCARD_VALID : Company::STATUS_CREDITCARD_INVALID))

    topic = TorqueBox::Messaging::Topic.new('/topics/companies/status_changed')
    topic.publish company.to_json
    true
  end
end
