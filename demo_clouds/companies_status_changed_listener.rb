require 'demo_cloud'
require 'json'

class CompaniesStatusChangedListener < TorqueBox::Messaging::MessageProcessor

  def on_message(body)
    company = JSON.parse body

    process_company(company)
  end

  def process_company(company)
    if company["status"] == "Valid"
      demo_cloud = DemoCloud.first_or_create owner: company["id"]
    end
  end

end
