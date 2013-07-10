require "net/http"
require "json"
require "demo_cloud"
require 'companies_status_changed_listener'

class ReplayService
  include TorqueBox::Messaging::Backgroundable

  always_background :replay

  def replay(companies = nil)
    if companies.nil?
      uri = URI('http://localhost:8080/companies/')
      companies = JSON.parse Net::HTTP.get(uri)
    end

    remove_unused_demo_clouds companies

    create_missing_demo_clouds companies
  end

  def create_missing_demo_clouds(companies)
    companies.each do |company|
      CompaniesStatusChangedListener.new.process_company(company)
    end
  end

  def remove_unused_demo_clouds(companies)
    unused_demo_clouds = DemoCloud.all.select do |demo_cloud|
      company_ids = companies.map { |company| company["id"] }
      not (company_ids.include? demo_cloud.owner)
    end

    unused_demo_clouds.each { |unused| unused.destroy }
  end

end
