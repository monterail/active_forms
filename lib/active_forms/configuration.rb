module ActiveForms
  class Configuration
    attr_accessor :url, :base_url, :api_key, :secret_key

    def initialize
      @url = { :protocol => "https", :host => 'api.activeforms.com', :port => 443 }
    end
  end
end