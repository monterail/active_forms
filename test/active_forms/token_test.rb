require 'test_helper'

class ActiveForms::EntryTest < Test::Unit::TestCase
  context "" do
    setup do
      configure
    end

    context "when sent ActiveForms::Token.all with multi-response" do
      setup do
        stub_get(/formaccesstokens/, success_response("get_formaccesstokens"))
        @tokens = ActiveForms::Token.all :apiFormCode => 'hipoteka'
      end

      should "respond with array of entry instances" do
        tokens = []
        ['asdf9j43f349jf23skf', 'asdf9j43fdfg23sksdf', 'asde4gw34tgezrgeskf',
          'aszxdre5gw345g435kf', 'asdf9zse6zs5WdAwskf'].each do |token_value|
          token = ActiveForms::Token.new(:value => token_value)
          tokens << token
          assert_equal token.value, token_value
          end

        tokens.each do |token|
          assert @tokens.include?(token)
        end
        assert_equal tokens.size, @tokens.size
      end
    end
  end
end