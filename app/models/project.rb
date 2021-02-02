class Project < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :content, presence: true

  default_scope { order(created_at: :desc) }
end
