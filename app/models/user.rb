class User < ApplicationRecord
  before_save { email.downcase! }
  before_destroy :can_destroy?

  has_many :projects, dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :username, presence: true, uniqueness: true
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX }

  has_secure_password

  paginates_per 10

  private

  def can_destroy?
    if admin && self.class.where(admin: true).count <= 1
      errors.add(:alert, 'Cannot delete the only remaining admin account.')
      throw :abort
    end
  end
end
