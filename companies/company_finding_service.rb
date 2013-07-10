require 'company'

class CompanyFindingService
  include TorqueBox::Messaging::Backgroundable

  always_background :create_company

  def self.find(condition)
    Company.all(condition)
  end

  def self.find_all
    Company.all
  end
end
