class Project < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :content, presence: true

  enum status: [ :todo, :doing, :done]
end
