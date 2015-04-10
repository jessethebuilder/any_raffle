FactoryGirl.define do
  sequence(:email){ |n| "test_#{n}@test.com" }

  factory :user do
    email
    password 'carltonlasiter'
  end

  factory :raffle do
    title Faker::Commerce.product_name
    description Faker::Lorem.paragraphs(paragrapsh_count = Random.rand(1..10)).join('<br>')
    price Random.rand(0..1000.0)
  end
end