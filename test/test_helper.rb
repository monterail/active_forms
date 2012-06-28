# encoding: UTF-8

require 'rubygems' if RUBY_VERSION < '1.9'
require 'bundler/setup'

require 'shoulda'
require 'fakeweb'

require 'active_forms'

FakeWeb.allow_net_connect = false

class Test::Unit::TestCase
  def teardown
    FakeWeb.clean_registry
  end

  def configure(opts = {})
    ActiveForms.configure do |c|
      c.api_url    = { :protocol => "https", :host => "api.example.com" }
      c.url        = { :protocol => "https", :host => "www.example.com" }
      c.base_url   = "client"
      c.api_key    = "123456"
      c.secret_key = "abcdef"
      opts.each do |k, v|
        c.send("#{k}=", v)
      end
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
      :body         => fixture(file || "success.xml")
    }
  end

  def error_response(file = nil)
    response = {
      :status       => ["401", "Unauthorized"],
      :content_type => "text/xml",
      :body         => fixture(file || "error.xml")
    }
  end

  def fixture(file)
    File.read(File.join(File.dirname(__FILE__), "fixtures", "#{file}"))
  end
end

def define_mapper(klass)
  Object.const_set(klass, Class.new(ActiveForms::Mapper))
  case klass
  when "Dummy"
    Dummy.class_eval  do
      columns :name, :formCode
    end
  end
end

def reset_mapper(klass)
  Object.send(:remove_const, klass) rescue nil
  define_mapper(klass)
end

define_mapper("Dummy")
