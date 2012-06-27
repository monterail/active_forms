# encoding: UTF-8

module ActiveForms
  class Configuration
    attr_accessor :api_url, :url, :base_url, :api_key, :secret_key

    def initialize
      @api_url = { :protocol => "https", :host => 'api.activeforms.com' }
      @url     = { :protocol => "https", :host => 'www.activeforms.com' }
    end
  end
end
