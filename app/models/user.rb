class User < ApplicationRecord
  has_secure_password
  has_many :comments 
  has_many :recipes 

  validates :password_digest, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true



  def user?
  self.role == "user"
  end

  def set_admin
    self.role ="admin"
    self.save
  end

  def admin?
    self.role == "admin"
  end

end
