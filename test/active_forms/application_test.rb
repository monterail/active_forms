require 'test_helper'

class ActiveForms::ApplicationTest < Test::Unit::TestCase
  context "" do
    setup do
      configure
    end

    context "instance" do
      setup do
        @application = ActiveForms::Application.new(
          :number     => "1234",
          :form_code  => "credit_card_application",
          :field_data => {
            :last_name     => "Kowalski",
            :ubezpieczenie => ["ubezpieczenie_karty", "na_zycie"]
          }
        )
      end

      should "have correctly built attributes" do
        attributes = {
          "number"     => "1234",
          "form_code"  => "credit_card_application",
          "field_data" => {
            "last_name"     => "Kowalski",
            "ubezpieczenie" => ["ubezpieczenie_karty", "na_zycie"]
          }
        }

        assert_equal attributes, @application.attributes
      end
    end

    context "when sent ActiveForms::Application.all with multi-response" do
      setup do
        stub_get(/applications/, success_response("get_applications"))
        @applications = ActiveForms::Application.all
      end

      should "respond with array of Application instances" do
        application1 = ActiveForms::Application.new(
          :number          => "12234",
          :formCode        => "credit_card_application",
          :formVersionCode => "version_1",
          :date            => "2007-08-23T12:43:03",
          :status          => "sent",
          :isPrintable     => "true"
        )

        application2 = ActiveForms::Application.new(
          :number          => "12235",
          :formCode        => "credit_card_application",
          :formVersionCode => "version_1",
          :date            => "2007-08-23T12:44:03",
          :status          => "sent",
          :isPrintable     => "true"
        )

        assert @applications.include?(application1)
        assert @applications.include?(application2)
        assert_equal 2, @applications.size
      end
    end

    context "when sent ActiveForms::Application.all with single-response" do
      setup do
        stub_get(/applications/, success_response("get_applications_single"))
        @applications = ActiveForms::Application.all
      end

      should "respond with array of Application instances" do
        application = ActiveForms::Application.new(
          :number          => "12234",
          :formCode        => "credit_card_application",
          :formVersionCode => "version_1",
          :date            => "2007-08-23T12:43:03",
          :status          => "sent",
          :isPrintable     => "true"
        )

        assert_equal [application], @applications
      end
    end
  end
end