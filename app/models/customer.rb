require 'nkf'

class Customer < ActiveRecord::Base
  validates :family_name, presence: true, length: {maximum: 40},
            format: {with: /\A[\p{Han}\p{Hiragana}\p{Katakana}\u30fc]+\z/, allow_blank: true}
  validates :given_name, presence: true, length: {maximum: 40},
            format: {with: /\A[\p{Han}\p{Hiragana}\p{Katakana}\u30fc]+\z/, allow_blank: true}
  validates :family_name_kana, presence: true, length: {maximum: 40}
  validates :given_name_kana, presence: true, length: {maximum: 40}

  before_validation do
    self.family_name_kana = NKF.nkf('-wh2', family_name_kana) if family_name_kana
    self.given_name_kana = NKF.nkf('-wh2', given_name_kana) if given_name_kana
  end
end
