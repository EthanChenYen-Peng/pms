class Project < ApplicationRecord
  validates :title, presence: true, uniqueness: {
    scope: :user
  }

  validates :content, presence: true
  validate :due_date_cannot_be_earlier_than_start_date

  belongs_to :user, counter_cache: true
  has_and_belongs_to_many :labels

  enum status: %i[todo doing done]
  enum priority: %i[low medium high]

  scope :title_or_content_contains,
        lambda { |pattern|
          where('title ILIKE (?) OR content ILIKE (?)',
                "%#{pattern}%",
                "%#{pattern}%")
        }

  paginates_per 10

  priorities.each do |level, _value|
    define_method "#{level}_priority?" do
      send("#{level}?")
    end

    define_method "#{level}_priority!" do
      send("#{level}!")
    end
  end

  def due_date_cannot_be_earlier_than_start_date
    errors.add(:due_date, :cannot_be_earlier_than_start_date) if due_date && start_date && (due_date < start_date)
  end
end
