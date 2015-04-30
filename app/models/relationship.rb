class Relationship < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :fan, :class_name => "User"
  belongs_to :hero, :class_name => "User"
end
