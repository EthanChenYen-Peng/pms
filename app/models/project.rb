class Project < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :content, presence: true

  enum status: %i[todo doing done]

  scope :title_contains,
        ->(pattern) { where('title ILIKE (?)', "%#{pattern}%") }
end
