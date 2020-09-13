class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates :password, confirmation: true, presence: true
  validates_presence_of :address, :city, :state, :zip, :name

  belongs_to :merchant

  has_secure_password

  enum role: %w(regular merchant admin)
end
