require 'live_cloud'
require 'json'
require 'companies_status_changed_listener'

class CompaniesReplayListener < TorqueBox::Messaging::MessageProcessor

  def on_message(body)
    companies = JSON.parse body

    remove_unused_live_clouds(companies)

    create_missing_live_clouds(companies)
  end


  def create_missing_live_clouds(companies)
    companies.each do |company|
      CompaniesStatusChangedListener.new.process_company(company)
    end
  end

  def remove_unused_live_clouds(companies)
    unused_live_clouds = LiveCloud.all.select do |live_cloud|
      company_ids = companies.map { |company| company["id"] }
      not (company_ids.include? live_cloud.owner)
    end

    unused_live_clouds.each { |unused| unused.destroy }
  end

end
