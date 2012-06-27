# encoding: UTF-8

require 'test_helper'

class ActiveForms::FormVersionTest < Test::Unit::TestCase
  context "" do
    setup do
      configure
    end

    context "when send ActiveForms::FormVersion.all with multi-response" do
      setup do
        stub_get(/forminfo/, success_response("get_forminfo.xml"))
        @versions = ActiveForms::FormVersion.all :apiFormCode => 'hipoteka'
      end

      should "get all versions of form" do
        formVersion1 = ActiveForms::FormVersion.new(
          :code => "1.0", :name => "Podstawowa", :status => "active",
          :description => "Pierwsza wersja wniosku",
          :creationDate => "2007-01-01 12:00:00+0100", :isPrintable => "false")
        formVersion2 = ActiveForms::FormVersion.new(
          :code => "1.1", :name => "Poprawki", :status => "inactive",
          :description => "Druga wersja wniosku",
          :creationDate => "2007-01-02 12:00:00+0100", :isPrintable => "true")
        formVersion3 = ActiveForms::FormVersion.new(
          :code => "1.2", :name => "Poprawki 2", :status => "inactive",
          :description => "Trzecia wersja wniosku",
          :creationDate => "2007-01-03 12:00:00+0100", :isPrintable => "true")

        assert @versions.include?(formVersion1)
        assert @versions.include?(formVersion2)
        assert @versions.include?(formVersion3)
      end
    end
  end
end
