module ActiveForms
  class Mapper

    class << self
      attr_reader :column_names

      protected

      def columns(*columns)
        @column_names ||= []
        @column_names += columns.map(&:to_s)

        columns.each do |column|
          define_method("#{column}") do
            @attributes["#{column}"]
          end

          define_method("#{column}=") do |value|
            @attributes["#{column}"] = value
          end
        end
      end
    end

    attr_reader :attributes

    def initialize(attributes = {})
      self.attributes = attributes
    end

    def attributes=(new_attributes = {})
      @attributes = HashWithIndifferentAccess.new

      # use attribute writers
      new_attributes.each { |k, v| respond_to?("#{k}=") ? send("#{k}=", v) : (@attributes[k] = v) }

      @attributes.stringify_keys!
    end

    def ==(comparison_object)
      attributes == comparison_object.attributes
    end

    alias_method :equal?, :==
    alias_method :eql?, :==
  end
end