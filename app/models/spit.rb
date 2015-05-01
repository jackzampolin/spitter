class Spit < ActiveRecord::Base
  belongs_to :users
  validates :content, presence: true
  validates :user_id, presence: true
  before_validation :set_username

  private

  def set_username
    self.username = User.where(id: self.user_id).first.username
  end
end
