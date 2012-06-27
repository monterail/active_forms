# encoding: UTF-8

require 'test_helper'

class ActiveForms::FormTest < Test::Unit::TestCase
  context "" do
    setup do
      configure
    end

    context "when sent ActiveForms::Form.all with multi-response" do
      setup do
        stub_get(/forms/, success_response("get_forms.xml"))
        @forms = ActiveForms::Form.all
      end

      should "respond with array of Form instances" do
        @form1 = ActiveForms::Form.new(
          :name              => "Wniosek o~karte kredytowa",
          :code              => "credit_card_application",
          :url               => "https://www.activeforms.com/mybank/wniosek_o_karte_kredytowa",
          :status            => "active",
          :activeReleaseCode => "version_1",
          :activeReleaseName => "Wersja pierwsza",
          :title             => "Wniosek o~karte kredytowa",
          :isPrintAgreement  => "isPrintable"
        )

        @form2 = ActiveForms::Form.new(
          :name   => "Wniosek o~kredyt hipoteczny",
          :code   => "mortgage_credit",
          :url    => "https://www.activeforms.com/mybank/wniosek_o_kredyt_hipoteczny",
          :status => "inactive"
        )

        assert @forms.include?(@form1)
        assert @forms.include?(@form2)
        assert_equal 2, @forms.size
      end
    end

    context "when sent ActiveForms::Form.all with single-response" do
      setup do
        stub_get(/forms/, success_response("get_forms_single.xml"))
        @forms = ActiveForms::Form.all
      end

      should "respond with array of Form instances" do
        @form = ActiveForms::Form.new(
          :name   => "Wniosek o~kredyt hipoteczny",
          :code   => "mortgage_credit",
          :url    => "https://www.activeforms.com/mybank/wniosek_o_kredyt_hipoteczny",
          :status => "inactive"
        )

        assert_equal [@form], @forms
      end
    end

    context "given a form with full url" do
      setup { @form = ActiveForms::Form.new(:url => "https://www.example2.com/client/pit") }

      should "return url as full_url" do
        assert_equal "https://www.example2.com/client/pit", @form.full_url
      end
    end

    context "given a form with no full url" do
      setup { @form = ActiveForms::Form.new(:url => "pit") }

      should "construct full_url" do
        assert_equal "https://www.example.com/client/pit", @form.full_url
      end
    end

    context "given a form with active status" do
      setup { @form = ActiveForms::Form.new(:status => "active") }

      should "respond with true when sent #active?" do
        assert @form.active?
      end
      should "respond with false when sent #inactive?" do
        assert !@form.inactive?
      end
    end

    context "given a form with inactive status" do
      setup { @form = ActiveForms::Form.new(:status => "inactive") }

      should "respond with true when sent #inactive?" do
        assert @form.inactive?
      end
      should "respond with false when sent #active?" do
        assert !@form.active?
      end
    end
  end
end
