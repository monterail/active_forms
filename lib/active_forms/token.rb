# encoding: UTF-8

class ActiveForms::Token < ActiveForms::Mapper
  columns :value

  class << self
    # required params:
    #   apiFormCode
    def all(params = {})
      response = ActiveForms::Request.get('formaccesstokens', params)

      hashes = response['formAccessTokens']['token']
      hashes = [hashes] if hashes.is_a?(Hash)

      objects = hashes.nil? ? [] : hashes.map { |attributes| new(attributes) }
    end
  end
end
