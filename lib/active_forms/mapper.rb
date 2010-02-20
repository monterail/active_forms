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

    attr_accessor :attributes

    def initialize(attributes = {})
      @attributes = HashWithIndifferentAccess.new
      @attributes.merge!(attributes)
      @attributes.stringify_keys!
    end

    def ==(comparison_object)
      attributes == comparison_object.attributes
    end

    alias_method :equal?, :==
    alias_method :eql?, :==
  end
end