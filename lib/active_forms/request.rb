# encoding: UTF-8

require 'digest/sha1'
require 'cgi'
require 'httparty'

module ActiveForms
  class Request
    attr_reader :http_method, :path, :params, :api_params, :uri, :options

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
      @api_params["apiVersion"]   = "3.0"
      @api_params["apiTimestamp"] ||= Time.now.strftime('%Y-%m-%dT%H:%M:%S.000 %z')
      @api_params["apiSig"]       = api_sig

      @uri = build_uri
      @options = build_options
    end

    def perform
      ActiveForms.log("[ActiveForms] Request: #{http_method.upcase} #{uri}")
      begin
        response = HTTParty.send(http_method.downcase, uri, options)
        verify_response(response)
      rescue
        response = HTTParty.send(http_method.downcase, uri, options)
        verify_response(response)
      end
      response
    end

    private

    def build_uri
      params     = http_method == "GET" ? @params.map { |k, v| "#{k}=#{CGI::escape(v)}" } : []
      api_params = @api_params.map do |k, v|
        if k == 'apiTimestamp'
          "#{k}=#{CGI::escape(v)}"
        else
          "#{k}=#{v}"
        end
      end

      url_with_path + "?" + [params, api_params].flatten.join("&")
    end

    def build_options
      ActiveForms.configuration.basic_auth ? { :basic_auth => ActiveForms.configuration.basic_auth } : {}
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

    def verify_response(response)
      exception = nil

      begin
        # force parsing response to detect parsing errors
        response.parsed_response

        ActiveForms.log("[ActiveForms] Response: #{response}")
        if response["error"]
          begin
            klass     = ("ActiveForms::" << response["error"]["code"].downcase.camelize).constantize
            exception = klass.new(response["error"]["message"])
          rescue NameError, NoMethodError
            exception = Error.new("Unknown exception: #{response["error"].inspect}")
          end
        elsif response.response.code !~ /^20\d$/
          exception = Error.new("Request returned status #{response.response.code} and does include properly formatted error message.")
        end
      rescue MultiXml::ParseError
        exception = ParseError.new($!.message)
      end

      unless exception.nil?
        exception.response = response
        raise exception
      end
    end
  end
end
