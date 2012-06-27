# encoding: UTF-8

class ActiveForms::FormVersion < ActiveForms::Mapper
  columns :name, :code, :url, :mailIntegration, :accessType, :authKey, :status,
    :description, :creationDate, :isPrintable

  class << self
    # required params:
    #   apiFormCode
    def all(params = {})
      response = ActiveForms::Request.get("forminfo", params)

      hashes = response["formInfo"]["formVersion"]
      hashes = [hashes] if hashes.is_a?(Hash)

      objects = hashes.nil? ? [] : hashes.map { |attributes| new(attributes) }
    end
  end
end
