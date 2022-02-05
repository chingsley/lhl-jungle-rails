class User < ActiveRecord::Base
  mount_uploader :picture, UserImageUploader

  has_secure_password


  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 8 }, :if => :password_digest_changed? # works without :if => :password_digest_changed?
  validates :password_confirmation, presence: true

  def self.authenticate_with_credentials(email, password)
    trimed_email = email.gsub(/\s+/, '')
    user = self.find_by_email(trimed_email) # self.find_by_email(email.downcase.strip)
    if user && user.authenticate(password)
      return user
    else
      return nil
    end
  end


  # override default find_by_email to implement a case-insensitive search by email
  def self.find_by_email(email)
    User.where('lower(email) = ?', email.downcase).first
  end

end


=begin
....................................................
trimed_email = email.gsub(/\s+/, '') 
# removes whitespace and returns the trimed string

You can add ! to trim the email in-place
email.gsub!(/\s+/, '') 
....................................................
=end
