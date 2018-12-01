class User < ApplicationRecord
  has_secure_password

  validates_presence_of :admin, :password_digest
  validates :email,
            uniqueness: { case_sensitive: false },
            presence: true,
            allow_blank: false
  validates :username,
            uniqueness: { case_sensitive: false },
            presence: true,
            allow_blank: false,
            format: { with: /\A[a-z0-9_.]{3,15}\z/ }
end
