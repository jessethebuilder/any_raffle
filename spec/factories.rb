FactoryGirl.define do
  sequence(:email){ |n| "test_#{n}@test.com" }

  factory :user do
    email
    password 'carltonlasiter'
  end

  factory :raffle do
    title Faker::Commerce.product_name
    description Faker::Lorem.paragraphs(paragrapsh_count = Random.rand(1..10)).join('<br>')
    ticket_price Random.rand(0..1000.0)
  end

  factory :prize do
    raffle
    name Faker::Commerce.product_name
  end

  factory :ticket do
    raffle
    email

    factory :winning_ticket do
      after(:build) do |tix, e|
        tix.prize = build(:prize)
      end
    end
  end
end