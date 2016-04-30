class Attending < ActiveRecord::Base
  belongs_to :event_id
  belongs_to :user_id
end
