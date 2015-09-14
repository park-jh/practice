require 'rails_helper'

RSpec.describe Customer, type: :model do
  let(:customer) { FactoryGirl.build(:customer) }

  example '妥当なオブジェクト' do
    expect(customer).to be_valid
  end

  %w{family_name given_name family_name_kana given_name_kana}.each do |column_name|
    example "#{column_name}は空であってはならない" do
      customer[column_name] = ''
      expect(customer).not_to be_valid
      expect(customer.errors[column_name]).to be_present
    end

    example "#{column_name}は40文字以内" do
      customer[column_name] = 'ア' * 41
      expect(customer).not_to be_valid
      expect(customer.errors[column_name]).to be_present
    end
  end

  %w{family_name given_name}.each do |column_name|
    example "#{column_name}は漢字、ひらがな、カタカナを含んでもよい" do
      customer[column_name] = '亜あア'
      expect(customer).to be_valid
    end

    example "#{column_name}は漢字、ひらがな、カタカナ以外の文字を含まない" do
      ['A', '1', '@'].each do |value|
        customer[column_name] = value
        expect(customer).not_to be_valid
        expect(customer[column_name]).to be_present
      end
    end
  end

  %w(family_name_kana given_name_kana).each do |column_name|
    example "#{column_name}に含まれるひらがなはカタカナに交換して受け入れる" do
      customer[column_name] = 'あいう'
      expect(customer).to be_valid
      expect(customer[column_name]).to eq('アイウ')
    end
  end

end
