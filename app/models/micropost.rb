class Micropost < ActiveRecord::Base
  
  belongs_to :user  # connecting the relationship to user
  
  validates :user_id, presence: true
end
