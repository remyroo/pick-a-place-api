class User < ApplicationRecord
  has_secure_password

  validates_presence_of :password_digest
  validates :email,
            uniqueness: { case_sensitive: false },
            presence: true,
            allow_blank: false
  validates :username,
            uniqueness: { case_sensitive: false },
            presence: true,
            allow_blank: false,
            format: { with: /\A[a-z0-9_.]{3,15}\z/ }

  def admin?
    role == 'admin'
  end

  def can_modify_user?(user_id)
    admin? || id.to_s == user_id.to_s
  end
end
