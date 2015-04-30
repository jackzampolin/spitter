class Follower < ActiveRecord::Base
  validates :follower, presence: true
  validates :followee, presence: true
end
