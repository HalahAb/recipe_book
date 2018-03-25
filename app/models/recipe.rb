class Recipe < ApplicationRecord
  has_many :comments
  has_many :categories
  belongs_to :user
  mount_uploaders :recipe_images, ImageUploader

  accepts_nested_attributes_for :categories, reject_if: :all_blank, allow_destroy: true
end
