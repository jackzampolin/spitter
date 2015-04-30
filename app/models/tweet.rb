class Tweet < ActiveRecord::Base
  validates :bat_signal, presence: true, length: { maximum: 140 }

  belongs_to :user
end
