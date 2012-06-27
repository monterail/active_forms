# encoding: UTF-8

class ActiveForms::Entry < ActiveForms::Mapper
  columns :number, :formCode, :formVersionCode, :date, :status, :isPrintable, :fieldData, :accessToken

  class << self

    def all(params = {})
      response = ActiveForms::Request.get("entries", params)

      hashes = response["entries"]["entry"]
      hashes = [hashes] if hashes.is_a?(Hash)

      objects = hashes.nil? ? [] : hashes.map { |attributes| new(attributes) }
    end

    # required params:
    #   apiFormCode                 - form's code
    #   apiNumber or apiEntryToken  - entry's number or token
    def find(params = {})
      response = ActiveForms::Request.get("entrydata", params)

      attributes = response["entryData"]

      new(attributes)
    end

    # required params:
    #   apiFormCode
    #   field id
    def create(params = {})
      response = ActiveForms::Request.post("entrydata", params)

      attributes = response["entryPutConfirmation"]

      new(attributes)
    end

    # required params:
    #   apiFormCode
    #   apiNumber or apiEntryToken
    def delete(params = {})
      response = ActiveForms::Request.delete("entrydata", params)
      response && response.code.to_i == 204
    end
  end

  def destroy
    ActiveForms::Entry.delete :apiFormCode => self.formCode, :apiNumber => self.number
  end
end