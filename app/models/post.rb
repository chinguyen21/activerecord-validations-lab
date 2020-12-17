class Post < ActiveRecord::Base
  validates :content, length: {minimum: 250}
  validates :summary, length: {maximum: 250}
  validates :category, inclusion: { in: %w(Non-Fiction Fiction), message: "%{value} is not a valid category"}
  validate :valid_title?

  def valid_title?
    words = ["Won't Believe", "Secret", "Top", "Guess"]
    if self.title.nil?
      errors.add(:title, "Title cannot be empty")
    elsif words.all? {|word| !self.title.include?(word) }
      errors.add(:title, "Title should be sufficiently clickbait-y.")
    end
  end
end
