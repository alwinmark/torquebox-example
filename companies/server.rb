require "company"
require "company_creation_service"
require "company_finding_service"
require "company_deletion_service"
require "company_replay_service"
require "json"

class Server < Sinatra::Base
  use TorqueBox::Session::ServletStore


  get '/' do
    companies = []
    if params.keys.empty?
      companies = CompanyFindingService.find_all
    else
      companies = CompanyFindingService.find(params)
    end
    companies.to_json
  end

  get '/active' do
    @company = CompanyFindingService.find(status: Company::STATUS_CREDITCARD_VALID)
    @company.to_json
  end

  get '/replay' do
    companies = CompanyFindingService.find_all
    CompanyReplayService.replay companies
    "success"
  end

  get '/status/:id' do
    @company = CompanyFindingService.find(id: params[:id]).first
    @company.status
  end

  get '/:id' do
    @company = CompanyFindingService.find(id: params[:id]).first
    @company.to_json
  end

  delete '/all' do
    CompanyDeletionService.delete_all
    "success"
  end

  delete '/:id' do
    CompanyDeletionService.delete_all(id: params[:id])
    "success"
  end

  post '/' do
    company = CompanyCreationService.create(params[:name], params[:credit_card_number])
    redirect to( "/status/#{company.id}" )
  end

  post '/:id' do
    values = { name: params[:name], credit_card_number: params[:credit_card_number] }
    CompanyUpdateService.update(params[:id], values)
    "success"
  end
end
