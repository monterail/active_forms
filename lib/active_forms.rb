require 'active_support'

require 'active_forms/configuration'
require 'active_forms/mapper'
require 'active_forms/request'

require 'active_forms/form'

module ActiveForms
  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end
  end

  class Error                   < StandardError; end

  class MissingParameter        < Error; end
  class ApiVersionNotSupported  < Error; end
  class MissingVendor           < Error; end
  class MissingResource         < Error; end
  class ResourceNotSupported    < Error; end
  class BadParameterFormat      < Error; end
  class ApiKeyInvalid           < Error; end
  class ApiTimestampInvalid     < Error; end
  class ApiSigInvalid           < Error; end
  class MethodNotAllowed        < Error; end
  class FormNotFound            < Error; end
  class FormVersionNotFound     < Error; end
  class ApplicationNotFound     < Error; end
end
