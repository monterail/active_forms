# encoding: UTF-8

require 'test_helper'

class ActiveForms::RequestTest < Test::Unit::TestCase
  context "" do
    setup { configure }

    context "GET request" do
      setup do
        @request = ActiveForms::Request.new(:get, "forms", :param => "a&b value", :apiTimestamp => "2010-02-18T01:18:19.210+0200", :apiParam => "apiValue", :apiKey => "fake", :apiVersion => "fake", :apiSig => "fake")
      end

      should "recognize params and apiParams" do
        assert_equal "a&b value", @request.params["param"]
        assert_equal "2010-02-18T01:18:19.210+0200", @request.api_params["apiTimestamp"]
      end

      should "set apiKey, apiVersion and apiSig params by itself" do
        assert_not_equal "fake", @request.api_params["apiKey"]
        assert_not_equal "fake", @request.api_params["apiVersion"]
        assert_not_equal "fake", @request.api_params["apiSig"]
      end

      should "have apiSig counted" do
        assert_equal "4d249bdd51f7da5fa4c9bfbdfc44ff5df291862b", @request.api_params["apiSig"]
      end

      should "have correct uri" do
        assert_same_uri "https://api.example.com/client/forms?apiSig=4d249bdd51f7da5fa4c9bfbdfc44ff5df291862b&apiKey=123456&apiTimestamp=2010-02-18T01%3A18%3A19.210%2B0200&apiVersion=3.0&param=a%26b+value&apiParam=apiValue", @request.uri
      end

      should "have params escaped in uri" do
        assert @request.uri.include?("a%26b+value")
        assert !@request.uri.include?("a&b value")
      end

      context "when performed with success" do
        setup do
          stub_get(@request.uri, success_response)
          @response = @request.perform
        end

        should "return response as no-error hash" do
          assert @response.is_a?(Hash)
          assert !@response.has_key?("error")
        end
      end

      context "when performed with failure" do
        setup do
          stub_get(@request.uri, error_response)
        end

        should "raise error" do
          assert_raise ActiveForms::ApiTimestampInvalid, "Api timestamp parameter value out of 15 minutes slot" do
            @request.perform
          end
        end
      end
    end

    context "POST request" do
      setup do
        @request = ActiveForms::Request.new(:post, "forms", :param => "a&b value", :apiTimestamp => "2010-02-18T01:18:19.218+0200", :apiParam => "apiValue")
      end

      should "have api_sig counted" do
        assert_equal "eaeb701de3bb1450859ef16eb9fda5c7db407e38", @request.api_params["apiSig"]
      end

      should "have correct uri" do
        assert_same_uri "https://api.example.com/client/forms?apiSig=eaeb701de3bb1450859ef16eb9fda5c7db407e38&apiKey=123456&apiTimestamp=2010-02-18T01%3A18%3A19.218%2B0200&apiVersion=3.0&apiParam=apiValue", @request.uri
      end
    end

    context "Request.post(path)" do
      setup do
        stub_post(/.+/, success_response)
        @response = ActiveForms::Request.post("forms", :param => "value")
      end

      should "be equivalent to Request.new(:post, path).perform" do
        request = ActiveForms::Request.new(:post, "forms", :param => "value")
        assert_equal @response.parsed_response, request.perform.parsed_response
      end
    end

    context "DELETE request" do
      setup do
        @request = ActiveForms::Request.new(:delete, "forms", :param => "a&b value", :apiTimestamp => "2010-02-18T01:18:19.218+0200", :apiParam => "apiValue")
      end

      should "have api_sig counted" do
        assert_equal "3d82ae9adde6db7cf3b4ef0d35e411f0cc6b1e42", @request.api_params["apiSig"]
      end

      should "have correct uri" do
        assert_same_uri "https://api.example.com/client/forms?apiSig=3d82ae9adde6db7cf3b4ef0d35e411f0cc6b1e42&apiKey=123456&apiTimestamp=2010-02-18T01%3A18%3A19.218%2B0200&apiVersion=3.0&apiParam=apiValue", @request.uri
      end
    end

    context "Request.delete(path)" do
      setup do
        stub_delete(/.+/, success_response)
        @response = ActiveForms::Request.delete("forms", :param => "value")
      end

      should "be equivalent to Request.new(:delete, path).perform" do
        request = ActiveForms::Request.new(:delete, "forms", :param => "value")
        assert_equal @response.parsed_response, request.perform.parsed_response
      end
    end
  end
end