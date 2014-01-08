# see Listing 9.29 http://ruby.railstutorial.org/chapters/updating-showing-and-deleting-users#top
namespace :db do
  desc "Fill database with sample data"
  
  task populate: :environment do
    User.create!(name: "Example User",                  # create! is just like the create 
                 email: "example@railstutorial.org",  # method, except it raises an exception 
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
  
  # to run this we need to $ rake db:reset; $ rake db:populate; $ rake test:prepare
end