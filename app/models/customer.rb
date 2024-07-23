class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :addresses, dependent: :destroy       
  
  def full_name
    last_name + '' + first_name
  end
  
  def full_name_kana
    last_name_kana + '' + first_name_kana
  end
  
  KATAKANA_REGEXP = /\A[\p{katakana}\u{30fc}]+\z/
  
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, format: { with: KATAKANA_REGEXP }
  validates :first_name_kana, format: { with: KATAKANA_REGEXP }
  validates :post_code, length: { is: 7 }
  validates :phone_number, presence: true
  validates :address, presence: true
  
end
