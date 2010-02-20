require 'test_helper'

class ActiveForms::MapperTest < Test::Unit::TestCase
  context "mapper class" do
    setup do
      configure
    end

    teardown do
      reset_mapper("Dummy")
    end

    context "when sent #columns" do
      setup do
        Dummy.send(:columns, :one, :two)
        @dummy = Dummy.new
      end

      should "define column accessors that read/write attributes" do
        assert @dummy.respond_to?(:one)
        assert @dummy.respond_to?(:two)

        @dummy.one = "fake"

        assert_equal "fake", @dummy.attributes["one"]
        assert_equal "fake", @dummy.one

        assert_same_elements ["one", "two", "name", "formCode"], Dummy.column_names
      end
    end

    context "instance" do
      setup do
        @dummy = Dummy.new(:name => "fake", :formCode => "code")
      end

      should "have attributes set" do
        assert_equal "fake", @dummy.name
        assert_equal "code", @dummy.formCode
      end
    end
  end
end