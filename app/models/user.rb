# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  has_secure_password
  
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  has_many :microposts

  validates :name, length: { minimum: 3, maximum: 50 }, presence: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  validates :email, presence: true,
    format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
    uniqueness: { case_sensitive: false }

  private
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
