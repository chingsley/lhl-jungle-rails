class User < ActiveRecord::Base
  mount_uploader :picture, UserImageUploader

  has_secure_password


  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

end
