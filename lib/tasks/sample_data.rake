# see Listing 9.29 http://ruby.railstutorial.org/chapters/updating-showing-and-deleting-users#top
namespace :db do
  desc "Fill database with sample data"
  
  task populate: :environment do
    make_users
    make_microposts
    make_relationships
  end
  # to run this we need to $ rake db:reset; $ rake db:populate; $ rake test:prepare
end


def make_users
  admin = User.create!(name: "Example User",          # create! is just like the create 
               email: "example@railstutorial.org",    # method, except it raises an exception 
               password: "foobar",                    # for an invalid user rather than returning false.   
               password_confirmation: "foobar",       # This noisier construction makes debugging easier by avoiding silent errors.
               admin: true)
               
  99.times do |n|
    name = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password = "password"
    User.create!(name: name,
                 email: email,
                 password: password,
                 password_confirmation: password)
  end
end
   
def make_microposts 
  users = User.all(limit: 6)
  50.times do
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.microposts.create!(content: content) }
 end
end
  
  
def make_relationships
  users = User.all
  user = users.first
  followed_users = users[2..50] # arbitrary
  followers      = users[3..40] # arbitray
  followed_users.each { |followed| user.follow!(followed) }
  followers.each { |follower| follower.follow!(user) }
end