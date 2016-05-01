class Event < ActiveRecord::Base
  belongs_to :user, :class_name => "User", :foreign_key => "created_by"
  has_many :attending 
end
