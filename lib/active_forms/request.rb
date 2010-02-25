require 'digest/sha1'
require 'cgi'
require 'httparty'

module ActiveForms
  class Request
    attr_reader :http_method, :path, :params, :api_params, :uri

    class << self
      def get(path, all_params = {})
        new(:get, path, all_params).perform
      end

      def post(path, all_params = {})
        new(:post, path, all_params).perform
      end

      def delete(path, all_params = {})
        new(:delete, path, all_params).perform
      end
    end

    def initialize(http_method, path, all_params = {})
      all_params.stringify_keys!

      @http_method = http_method.to_s.upcase
      @path        = path.to_s
      @api_params  = {}
      @params      = {}

      all_params.each do |k, v|
        if k.starts_with?("api")
          @api_params[k] = v
        else
          @params[k] = v
        end
      end

      @api_params["apiKey"]       = ActiveForms.configuration.api_key
      @api_params["apiVersion"]   = "1.0"
      @api_params["apiTimestamp"] ||= Time.now.utc.iso8601(3)
      @api_params["apiSig"]       = api_sig

      @uri = build_uri
    end

    def perform
      response = HTTParty.send(http_method.downcase, uri)
      raise_error(response)
      response
    end

    private

    def build_uri
      params     = http_method == "GET" ? @params.map { |k, v| "#{k}=#{CGI::escape(v)}" } : []
      api_params = @api_params.map { |k, v| "#{k}=#{v}" }

      url_with_path + "?" + [params, api_params].flatten.join("&")
    end

    def url_with_path
      url = ActiveForms.configuration.api_url[:protocol] + "://" + ActiveForms.configuration.api_url[:host]
      [url, ActiveForms.configuration.base_url, path].join('/')
    end

    def api_sig
      string = [
        http_method,
        url_with_path,
        api_params["apiKey"],
        api_params["apiTimestamp"],
        ActiveForms.configuration.secret_key
      ].join.downcase

      Digest::SHA1.hexdigest(string)
    end

    def raise_error(response)
      if response["error"]
        klass = ("ActiveForms::" << response["error"]["code"].downcase.camelize).constantize
        raise klass.new(response["error"]["message"])
      end
    end
  end
end
