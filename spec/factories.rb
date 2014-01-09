FactoryGirl.define do
  
  # user factory
  factory :user do
    #name      "Mark C Mitchell"
    #email     "mark@markcmitchell.net"
    # previously hardcoded (above). Now, using sequences instead:
    
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    password  "foobar"
    password_confirmation "foobar"
    
    factory :admin do   # nested factory for admin users. Can call FactoryGirl.create(:admin)
      admin true
    end
    
  end
  
  
  
  
end