require 'bcrypt'

class User < ActiveRecord::Base

  include BCrypt

  has_many :spits

  # validates :username, presence: true
  # validates :email, presence: true
  # validates :password_hash, presence: true

  def password
    @password ||= Password.new(password_hash) #if password_hash
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def create

  end
end
