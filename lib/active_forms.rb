# encoding: UTF-8

require 'active_support'
require 'active_support/core_ext/hash/indifferent_access'
require 'active_support/core_ext/string/inflections'
require 'active_support/core_ext/string/starts_ends_with'

require 'active_forms/configuration'
require 'active_forms/mapper'
require 'active_forms/request'
require 'active_forms/version'

require 'active_forms/application'
require 'active_forms/application_print'
require 'active_forms/entry'
require 'active_forms/entry_printout'
require 'active_forms/form'
require 'active_forms/form_version'
require 'active_forms/token'

module ActiveForms
  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end
  end

  class Error < StandardError; end

  class ApiKeyInvalid             < Error; end
  class ApiSigInvalid             < Error; end
  class ApiTimestampInvalid       < Error; end
  class ApiVersionNotSupported    < Error; end
  class ApplicationNotFound       < Error; end
  class ApplicationNotSent        < Error; end
  class BadParameterFormat        < Error; end
  class FieldNotFound             < Error; end
  class FieldNotMultiple          < Error; end
  class Forbidden                 < Error; end
  class FormActiveVersionNotFound < Error; end
  class FormNotFound              < Error; end
  class FormVersionNotFound       < Error; end
  class InternalServerError       < Error; end
  class MethodNotAllowed          < Error; end
  class MissingParameter          < Error; end
  class MissingResource           < Error; end
  class MissingVendor             < Error; end
  class NullResponse              < Error; end
  class OptionNotFound            < Error; end
  class ResourceNotSupported      < Error; end
  class TemplateNotFound          < Error; end
  class Unauthorized              < Error; end
end
