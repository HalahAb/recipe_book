class User < ApplicationRecord
  has_secure_password
  has_many :comments 
  has_many :recipes 

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
