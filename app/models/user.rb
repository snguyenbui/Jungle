class User < ActiveRecord::Base
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, format: { with: /\A[^\W]+@[a-z0-9]+\.[a-z]{2,}\z/i } #regex \A => start of string, [^\W] => anything except non-word character, @[a-z0-9] => @ followed by alphanumirics, \.[a-z]{2,} => . followed by at least 2 letters, \z => end of string, /i => case insensitive option
  validates :password_digest, presence: true
end
