class Article < ActiveRecord::Base
  has_many :likes, dependent: :destroy

  validates_with ArticleUrlValidator
  validates_presence_of :title
  validates_numericality_of :posted_by, only_integer: true
end
