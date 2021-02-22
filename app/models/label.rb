class Label < ApplicationRecord
  belongs_to :user
  before_save :unique_to_a_user?

  def unique_to_a_user?
    if self.user.labels.find_by("name ILIKE ?", self.name)
      errors.add(:base, I18n.t('label.create.duplicate'))
      throw :abort
    end
  end
end
