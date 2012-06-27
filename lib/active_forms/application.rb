# encoding: UTF-8

class ActiveForms::Application < ActiveForms::Mapper
  columns :number, :formCode, :formVersion, :date, :status, :isPrintable, :fieldData

  class << self
    # required params:
    #   apiStatus = sent | saved | sent_to_be
    def all(params = {})
      response = ActiveForms::Request.get("applications", params)

      hashes = response["applications"]["application"]
      hashes = [hashes] if hashes.is_a?(Hash)

      objects = hashes.nil? ? [] : hashes.map { |attributes| new(attributes) }
    end

    # required params:
    #   apiFormCode - Form's code
    #   apiNumber   - Application's number
    def find(params = {})
      response = ActiveForms::Request.get("applicationdata", params)

      attributes = response["applicationData"]

      new(attributes)
    end
  end
end