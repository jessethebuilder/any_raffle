FactoryGirl.define do
  sequence(:email){ |n| "test_#{n}@test.com" }

  factory :user do
    email
    password 'carltonlasiter'
    # name Faker::Company.name
  end

  factory :raffle do
    # user
    title Faker::Commerce.product_name
    description Faker::Lorem.paragraphs(paragraph_count = Random.rand(1..10)).join('<br>')
    ticket_price Random.rand(0..1000.0)
    # association :prizes, factory: :prize

    #a Raffle must have an end_time and/or a ticket_max must be specified. Here we make it random
    case Random.rand(1..3)
      when 1
        end_time Time.now + Random.rand(1..10000).minutes
      when 2
        ticket_max Random.rand(1..100000)
      when 3
        end_time Time.now + Random.rand(1..10000).minutes
        ticket_max Random.rand(1..100000)
    end

    # after(:build)do |r, eval|
    #   r.prizes << build(:prize)
    # end

    factory :raffle_with_end_time do
      end_time Time.now + Random.rand(1..10000).minutes
      ticket_max nil
    end

    factory :raffle_with_ticket_max do
      ticket_max Random.rand(1..100000)
      end_time nil
    end

    # factory :raffle_with_image do
    #   image Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/test_image.jpg')))
    # end
  end

  factory :prize do
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