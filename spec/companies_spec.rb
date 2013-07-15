require 'spec_helper'
require 'sinatra'
require_relative '../companies/company.rb'

describe "Companies" do

  #the gsub thingy is needed to indent the yaml file correctly
  app = <<-END.gsub(/^ {4}/,'')
    application:
      root: #{File.dirname(__FILE__)}/../companies
      env: testing
    web:
      context: /test/companies
  END

  deploy(app)

  describe "environment" do
    it "should be testing" do
      response = Net::HTTP.get_response(URI("http://localhost:8080/test/companies/env"))
      response.body.should eq("testing")
    end
  end

  describe "create a company" do

    describe "with valid credit card" do
      subject { post_json("/test/companies/", name: "companies_test", credit_card_number: "1234") }

      after(:each) do
        Company.all.destroy
      end

      it  { should response_with_status_code(200) }

      describe "responding with object" do
        it { should respond_object_with("id").not_nil }

        it { should respond_object_with("name").and_value("companies_test") }

        it { should respond_object_with("credit_card_number").and_value("1234") }

        it { should respond_object_with("status").and_value(Company::STATUS_CREATED) }
      end

      describe "saved object" do
        subject do
          id = post_json("/test/companies/",
            name: "companies_test",
            credit_card_number: "1234"
          )[:object]["id"]

          Company.get(id)
        end

        it { should_not be(nil) }

        it "it should set name" do
          subject.name.should eq("companies_test")
        end

        it "it should set credit_card_numequalr" do
          subject.credit_card_number.should eq("1234")
        end

        it "should set status" do
          subject.status.should eq(Company::STATUS_CREATED)
        end
      end

#      remote_describe "sending message" do
#
#        it "should receive a message" do
#          values = post_json("/test/companies/", name: "companies_test", credit_card_number: "1234")[:object]
##          topic = TorqueBox::Messaging::Topic.new('/topics/companies/created')
#          message = topic.receive()
#          message.should_not be_nil
#        end
#      end
    end

    describe "with invalid credit card" do
      subject { post_json "/test/companies" }

    end
  end

  describe "get companies" do
    subject { get_json "/test/companies/" }

    it { should response_with_status_code(200) }

    describe "json_object" do
      subject { get_json("/test/companies/")[:object] }

      it { should be_a(Array) }
    end
  end
end
