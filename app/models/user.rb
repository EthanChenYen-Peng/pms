class User < ApplicationRecord
  has_many :projects

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  has_secure_password
end
