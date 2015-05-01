class Favorite < ActiveRecord::Base
  validates :user_id, presence: true
  validates :spit_id, presence: true

  has_one :user
end
