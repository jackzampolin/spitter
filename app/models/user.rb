class User < ActiveRecord::Base
  has_many :tweets
  has_many :fans, :through => :relationships
  has_many :heroes, :through => :relationships
  has_many :i_am_a_fan_relationships, :class_name => "Relationship", :foreign_key => "hero_id"
  has_many :i_am_a_hero_relationships, :class_name => "Relationship", :foreign_key => "fan_id"

  validates :username, presence:true, length: { maximum: 20 }
  validates :encrypted_password, presence:true, length: { in: 6..20 }

  def password=(plaintext)
    self.encrypted_password = BCrypt::Password.create(plaintext)
  end
end
