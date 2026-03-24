# frozen_string_literal: true

require_relative '../credit_card'
require_relative '../substitution_cipher'
require_relative '../double_trans_cipher'
require_relative '../sk_cipher'
require 'minitest/autorun'
require 'minitest/rg'

describe 'Test card info encryption' do
  before do
    @cc = CreditCard.new('4916603231464963', 'Mar-30-2020',
                         'Soumya Ray', 'Visa')
    @key = 3
  end

  ciphers = [
    { type: SubstitutionCipher::Caesar, key: -> { 3 } },
    { type: SubstitutionCipher::Permutation, key: -> { 3 } },
    { type: DoubleTranspositionCipher, key: -> { 3 } },
    { type: ModernSymmetricCipher, key: -> { ModernSymmetricCipher.generate_new_key } }
  ]

  ciphers.each do |cipher|
    describe "Using #{cipher[:type]} cipher" do
      it 'should generate a key (if applicable)' do
        if cipher[:type] == ModernSymmetricCipher
          @test_key = ModernSymmetricCipher.generate_new_key
          _( @test_key ).wont_be_nil
          _( @test_key ).must_be_instance_of String
        end
      end
      
      it 'should encrypt card information' do
        key = cipher[:key].call
        enc = cipher[:type].encrypt(@cc, key)
        _(enc).wont_equal @cc.to_s
        _(enc).wont_be_nil
      end

      it 'should decrypt text' do
        key = cipher[:key].call
        enc = cipher[:type].encrypt(@cc, key)
        dec = cipher[:type].decrypt(enc, key)
        _(dec).must_equal @cc.to_s
      end
    end
  end

  # describe 'Using Caesar cipher' do
  #   it 'should encrypt card information' do
  #     enc = SubstitutionCipher::Caesar.encrypt(@cc, @key)
  #     _(enc).wont_equal @cc.to_s
  #     _(enc).wont_be_nil
  #   end

  #   it 'should decrypt text' do
  #     enc = SubstitutionCipher::Caesar.encrypt(@cc, @key)
  #     dec = SubstitutionCipher::Caesar.decrypt(enc, @key)
  #     _(dec).must_equal @cc.to_s
  #   end
  # end

  # describe 'Using Permutation cipher' do
  #   it 'should encrypt card information' do
  #     enc = SubstitutionCipher::Permutation.encrypt(@cc, @key)
  #     _(enc).wont_equal @cc.to_s
  #     _(enc).wont_be_nil
  #   end

  #   it 'should decrypt text' do
  #     enc = SubstitutionCipher::Permutation.encrypt(@cc, @key)
  #     dec = SubstitutionCipher::Permutation.decrypt(enc, @key)
  #     _(dec).must_equal @cc.to_s
  #   end
  # end

  # # TODO: Add tests for double transposition and modern symmetric key ciphers
  # #       Can you DRY out the tests using metaprogramming? (see lecture slide)
  # describe 'Using Double Transposition cipher' do
  #   it 'should encrypt card information' do
  #     enc = DoubleTranspositionCipher.encrypt(@cc, @key)
  #     _(enc).wont_equal @cc.to_s
  #     _(enc).wont_be_nil
  #   end

  #   it 'should decrypt text' do
  #     enc = DoubleTranspositionCipher.encrypt(@cc, @key)
  #     dec = DoubleTranspositionCipher.decrypt(enc, @key)
  #     _(dec).must_equal @cc.to_s
  #   end
  # end
end
