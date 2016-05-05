class Event < ActiveRecord::Base
  belongs_to :user, :class_name => "User", :foreign_key => "created_by"
  has_many :attending,  dependent: :destroy
  has_many :users, through: :attending
  has_many :permission,  dependent: :destroy
  has_many :users, through: :permission
end
