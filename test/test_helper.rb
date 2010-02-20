require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'fakeweb'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'active_forms'

FakeWeb.allow_net_connect = false

class Test::Unit::TestCase
  def teardown
    FakeWeb.clean_registry
  end

  def configure
    ActiveForms.configure do |c|
      c.url        = { :protocol => "https", :host => "api.example.com", :port => 443 }
      c.base_url   = "client"
      c.api_key    = "123456"
      c.secret_key = "abcdef"
    end
  end

  def assert_same_uri(expected, actual)
    expected ||= ""
    actual   ||= ""
    expected_url, expected_params = expected.split('?', 2)
    actual_url, actual_params     = actual.split('?', 2)
    expected_params = expected_params.to_s.split('&')
    actual_params   = actual_params.to_s.split('&')

    assert_equal expected_url, actual_url, "urls are not equal"
    assert_same_elements expected_params, actual_params, "params are not equal"
  end

  def stub_get(uri, response = {})
    FakeWeb.register_uri(:get, uri, response)
  end

  def stub_post(uri, response = {})
    FakeWeb.register_uri(:post, uri, response)
  end

  def stub_delete(uri, response = {})
    FakeWeb.register_uri(:delete, uri, response)
  end

  def success_response(file = nil)
    response = {
      :status       => ["200", "OK"],
      :content_type => "text/xml",
      :body         => fixture(file || "success")
    }
  end

  def error_response(file = nil)
    response = {
      :status       => ["401", "Unauthorized"],
      :content_type => "text/xml",
      :body         => fixture(file || "error")
    }
  end

  def fixture(file)
    File.read(File.join(File.dirname(__FILE__), "fixtures", "#{file}.xml"))
  end
end
