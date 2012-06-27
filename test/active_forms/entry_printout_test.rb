require 'test_helper'

class ActiveForms::EntryPrintoutTest < Test::Unit::TestCase
  context "" do
    setup do
      configure
    end

    context "instance" do
      setup do
        @entry         = ActiveForms::EntryPrintout.new(
          :number            => "1234",
          :form_code         => "credit_card_entry",
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
          "form_code"         => "credit_card_entry",
          "form_version_code" => "version_1",
          "date"              => "2007-08-23T12:43:03",
          "status"            => "sent",
          "content_type"      => "application/pdf",
          "print_content"     => "wAARCAMABAADASIA"
        }

        assert_equal attributes, @entry.attributes
      end
    end

    context "when sent ActiveForms::EntryPrintout.find with form code and application number" do
      setup do
        stub_get(/entryprintout/, success_response("get_entryprintout"))
        @entry_printout = ActiveForms::EntryPrintout.find(:formCode => "credit_card_entry", :number => "23456")
      end

      should "respond with ActiveForms::EntryPrintout instance" do
        entry_printout  = ActiveForms::EntryPrintout.new(
          :number          => "23456",
          :formCode        => "credit_card_entry",
          :formVersionCode => "version_1",
          :date            => "2007-08-23T12:43:03",
          :status          => "sent",
          :contentType     => "application/pdf",
          :printoutContent    => "/9j/4AAQSkZJRgABAQEASABIAAD/2wBDAAgGBgcGBQgHBwcJCQgKDBQNDAsLDBkSEw8UHRofHh0aHBwgJC4nICIsIxwcKDcpLDAxNDQ0Hyc5PTgyPC4zNDL/2wBDAQkJCQwLDBgNDRgyIRwhMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjL/wAARCAMABAADASIA"
        )

        assert_equal entry_printout, @entry_printout
      end
    end
  end
end
