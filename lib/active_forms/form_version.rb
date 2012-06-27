# encoding: UTF-8

class ActiveForms::FormVersion < ActiveForms::Mapper
  columns :name, :code, :url, :mailIntegration, :accessType, :authKey, :status,
    :description, :creationDate, :isPrintable

  class << self
    # required params:
    #   apiFormCode
    def all(params = {})
      response = ActiveForms::Request.get("forminfo", params)

      versions = response["formInfo"]["formVersion"]
      versions = [versions] if versions.is_a?(Hash)

      versions.present? ? versions.map { |attributes| new(attributes) } : []
    end
  end
end
