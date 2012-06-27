# encoding: UTF-8

require 'test_helper'

class ActiveForms::ApplicationPrintTest < Test::Unit::TestCase
  context "" do
    setup do
      configure
    end

    context "instance" do
      setup do
        @application         = ActiveForms::ApplicationPrint.new(
          :number            => "1234",
          :form_code         => "credit_card_application",
          :form_version_code => "version_1",
          :date              => "2007-08-23T12:43:03",
          :status            => "sent",
          :content_type      => "application/pdf",
          :print_content     => "wAARCAMABAADASIA"
        )
      end

      should "have correctly built attributes" do
        attributes            = {
          "number"            => "1234",
          "form_code"         => "credit_card_application",
          "form_version_code" => "version_1",
          "date"              => "2007-08-23T12:43:03",
          "status"            => "sent",
          "content_type"      => "application/pdf",
          "print_content"     => "wAARCAMABAADASIA"
        }

        assert_equal attributes, @application.attributes
      end
    end

    context "when sent ActiveForms::ApplicationPrint.find with form code and application number" do
      setup do
        stub_get(/applicationprint/, success_response("get_applicationprint.xml"))
        @application_print = ActiveForms::ApplicationPrint.find(:apiFormCode => "credit_card_application", :apiNumber => "23456")
      end

      should "respond with ApplicationPrint instance" do
        application_print  = ActiveForms::ApplicationPrint.new(
          :number          => "23456",
          :formCode        => "credit_card_application",
          :formVersionCode => "version_1",
          :date            => "2007-08-23T12:43:03",
          :status          => "sent",
          :contentType     => "application/pdf",
          :printContent    => "/9j/4AAQSkZJRgABAQEASABIAAD/2wBDAAgGBgcGBQgHBwcJCQgKDBQNDAsLDBkSEw8UHRofHh0aHBwgJC4nICIsIxwcKDcpLDAxNDQ0Hyc5PTgyPC4zNDL/2wBDAQkJCQwLDBgNDRgyIRwhMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjL/wAARCAMABAADASIA"
        )

        assert_equal application_print, @application_print
      end
    end
  end
end
