class Project < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :content, presence: true

  enum status: %i[todo doing done]
  enum priority: %i[low medium high]

  scope :title_contains,
        ->(pattern) { where('title ILIKE (?)', "%#{pattern}%") }


  paginates_per 15

  priorities.each do |level, value|
    define_method "#{level}_priority?" do
      send("#{level}?")
    end

    define_method "#{level}_priority!" do
      send("#{level}!")
    end
  end
end
