# spec/factories/hotels.rb
FactoryGirl.define do
  factory :hotel do |f|
    f.name "Test Hotel"
    f.country_code "XYZ"
    f.average_price 80
    #f.description "a normal description"
  end
end