class ActiveForms::ApplicationPrint < ActiveForms::Mapper
  columns :formCode, :formVersionCode, :number, :date, :status, :contentType, :printContent

  class << self
    # required params:
    #   apiFormCode - Form's code
    #   apiNumber   - Application's number
    def find(params = {})
      response = ActiveForms::Request.get("applicationprint", params)

      attributes = response["applicationPrint"]

      new(attributes)
    end
  end

  def printContent=(value)
    @attributes["printContent"] = value.is_a?(String) ? value.strip : super
  end
end