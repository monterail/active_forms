# encoding: UTF-8

require 'test_helper'

class ActiveForms::EntryTest < Test::Unit::TestCase
  context "" do
    setup do
      configure
    end

    context "instance" do
      setup do
        @entry = ActiveForms::Entry.new(
          :number     => "1234",
          :form_code  => "credit_card_entry",
          :field_data => {
            :last_name     => "Kowalski",
            :ubezpieczenie => ["ubezpieczenie_karty", "na_zycie"]
          }
        )
      end

      should "have correctly built attributes" do
        attributes = {
          "number"     => "1234",
          "form_code"  => "credit_card_entry",
          "field_data" => {
            "last_name"     => "Kowalski",
            "ubezpieczenie" => ["ubezpieczenie_karty", "na_zycie"]
          }
        }

        assert_equal attributes, @entry.attributes
      end
    end

    context "when sent ActiveForms::Entry.all with multi-response" do
      setup do
        stub_get(/entries/, success_response("get_entries.xml"))
        @entries = ActiveForms::Entry.all
      end

      should "respond with array of entry instances" do
        entry1 = ActiveForms::Entry.new(
          :number          => "12234",
          :formCode        => "credit_card_entry",
          :formVersionCode => "version_1",
          :date            => "2007-08-23T12:43:03",
          :status          => "sent",
          :isPrintable     => "true"
        )

        entry2 = ActiveForms::Entry.new(
          :number          => "12235",
          :formCode        => "credit_card_entry",
          :formVersionCode => "version_1",
          :date            => "2007-08-23T12:44:03",
          :status          => "sent",
          :isPrintable     => "true"
        )

        assert @entries.include?(entry1)
        assert @entries.include?(entry2)
        assert_equal 2, @entries.size
      end
    end

    context "when sent ActiveForms::Entry.all with single-response" do
      setup do
        stub_get(/entries/, success_response("get_entries_single.xml"))
        @entries = ActiveForms::Entry.all
      end

      should "respond with array of entry instances" do
        entry = ActiveForms::Entry.new(
          :number          => "12234",
          :formCode        => "credit_card_entry",
          :formVersionCode => "version_1",
          :date            => "2007-08-23T12:43:03",
          :status          => "sent",
          :isPrintable     => "true"
        )

        assert_equal [entry], @entries
      end
    end

    context "when post entry data by ActiveForms::Entry.create" do
      setup do
        stub_post(/entrydata/, success_response("post_entrydata.xml"))
        @entry = ActiveForms::Entry.create :apiFormCode => 'credit_card_entry'
      end

      should "respond instance of ActiveForms::Entry and accessToken" do
        entry = ActiveForms::Entry.new(
          :number => "12234",
          :formCode => "credit_card_entry",
          :formVersionCode => "version_1",
          :date => "2008-01-01T00:00:00.00+0000",
          :status => "saved",
          :isPrintable => "true",
          :accessToken => "43r9j34f9j3"
        )
        assert_equal entry, @entry
      end
    end

    context "when sent ActiveForms::Entry.destroy on got entry" do
      setup do
        @response = { :status => ["204", "No content"], :content_type => "text/xml"}
        stub_delete(/entrydata/, @response)
        stub_get(/entries/, success_response("get_entries.xml"))
        @entries = ActiveForms::Entry.all
      end

      should "respond with 204 status" do
        @entries.each do |entrydata|
          assert entrydata.destroy
          assert ActiveForms::Entry.delete({ :apiFormCode => entrydata.formCode, :apiNumber => entrydata.number })
        end
      end
    end

  end
end