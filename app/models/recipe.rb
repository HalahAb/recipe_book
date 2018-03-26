class Recipe < ApplicationRecord
  has_many :comments, dependent: :destroy 
  has_many :categories, dependent: :destroy 
  belongs_to :user
  mount_uploaders :recipe_images, ImageUploader

  accepts_nested_attributes_for :categories, reject_if: :all_blank, allow_destroy: true

  def duration
    prep_time_minutes.to_i + cooking_time_minutes.to_i
  end

  def verify 
    self.verified = true
    self.save
  end

  def unverify 
    self.verified = false
    self.save
  end

end
