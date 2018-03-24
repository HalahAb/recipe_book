class Recipe < ApplicationRecord
  has_many :comments
  has_many :categories
  belongs_to :user
end
