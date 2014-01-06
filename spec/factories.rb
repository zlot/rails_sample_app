FactoryGirl.define do
  factory :user do
    name      "Mark C Mitchell"
    email     "mark@markcmitchell.net"
    password  "foobar"
    password_confirmation "foobar"
  end
end