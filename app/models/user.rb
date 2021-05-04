class User < ActiveRecord::Base
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, uniqueness: { case_sensitive: false }, format: { with: /\A[^\W]+@[a-z0-9]+\.[a-z]{2,}\z/i } #regex \A => start of string, [^\W] => anything except non-word character, @[a-z0-9] => @ followed by alphanumirics, \.[a-z]{2,} => . followed by at least 2 letters, \z => end of string, /i => case insensitive option
  validates :password, presence: true, :confirmation =>true, length: { minimum: 8 } 
  validates_confirmation_of :password

  def self.authenticate_with_credentials(email, password)
    if user = User.find_by(email: email.downcase.strip)&.authenticate(password)
      user
    else
      nil
    end
  end
end
