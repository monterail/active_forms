require 'test_helper'

class ActiveFormsTest < Test::Unit::TestCase
  should "configure with block" do
    ActiveForms.configure do |c|
      c.url        = "AnUrl"
      c.base_url   = "MyBaseUrl"
      c.api_key    = "MyApiKey"
      c.secret_key = "SuperSecret"
    end

    assert_equal "AnUrl",       ActiveForms.configuration.url
    assert_equal "MyBaseUrl",   ActiveForms.configuration.base_url
    assert_equal "MyApiKey",    ActiveForms.configuration.api_key
    assert_equal "SuperSecret", ActiveForms.configuration.secret_key
  end
end
