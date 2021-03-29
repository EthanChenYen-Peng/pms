class User < ApplicationRecord
  extend FriendlyId
  friendly_id :username, use: :slugged

  before_save { email.downcase! }
  before_destroy :can_destroy?

  has_many :projects, dependent: :destroy
  has_one_attached :avatar

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :username, presence: true, uniqueness: true
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX }

  has_secure_password

  paginates_per 10

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end

  private

  def can_destroy?
    if admin && self.class.where(admin: true).count <= 1
      errors.add(:base, 'Cannot delete the only remaining admin account.')
      throw :abort
    end
  end
end
