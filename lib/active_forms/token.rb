# encoding: UTF-8

class ActiveForms::Token < ActiveForms::Mapper
  columns :value

  class << self
    # required params:
    #   apiFormCode
    def all(params = {})
      response = ActiveForms::Request.get('formaccesstokens', params)

      tokens = response['formAccessTokens']['token']
      tokens = [tokens] if tokens.is_a?(Hash)

      objects = tokens.present? ? tokens.map { |attributes| new(attributes) } : []
    end
  end
end
