class Micropost < ActiveRecord::Base
  
  belongs_to :user  # connecting the relationship to user
  
  default_scope -> { order('created_at DESC') }   # ordering microposts.
  # note the above is a Proc (procedure), aka a lambda. It takes in a block,
  #  and then evaluates it when called with the call method.
  
  validates :content, presence: true, length: { maximum: 140 }
  
  validates :user_id, presence: true
end
