require 'bcrypt'

class User < ActiveRecord::Base

  include BCrypt

  has_many :spits
  has_many :favorites

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

  def followers
    Follower.where(followee: self.id).map(&:follower).map do |user_id|
      User.where(id: user_id).first
    end
  end

  def following
    Follower.where(follower: self.id).map(&:followee).map do |user_id|
      User.where(id: user_id).first
    end
  end
end
