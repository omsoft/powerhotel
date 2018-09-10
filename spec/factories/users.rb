# spec/factories/users.rb
FactoryGirl.define do
  factory :user do |f|
    f.email "my@email.com"
    f.first_name "Gengis"
    f.last_name "Khan"
    f.password "my_secret_password"
  end
end