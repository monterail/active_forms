# encoding: UTF-8

class ActiveForms::EntryPrintout < ActiveForms::Mapper
  columns :formCode, :formVersionCode, :number, :date, :status, :contentType, :identifier, :printoutContent

  class << self
    # required params:
    #   apiFormCode - Form's code
    #   apiNumber   - Application's number
    def find(params = {})
      response = ActiveForms::Request.get("entryprintout", params)

      attributes = response["entryPrintout"]

      new(attributes)
    end
  end

  def printoutContent=(value)
    @attributes["printoutContent"] = value.is_a?(String) ? value.strip : super
  end
end