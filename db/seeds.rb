u = User.create! :email => 'test@test.com', :password => 'testtest'

r = Raffle.new :title => Faker::Commerce.product_name, :description => Faker::Lorem.paragraphs(paragraph_count = Random.rand(1..10)),
                                                       :ticket_price => Random.rand(0..10000.0)
u.raffles << r
# r.save!

10.times do
  p = Prize.new(:name => Faker::Commerce.product_name, :description => Faker::Lorem.sentences(sentence_count = Random.rand(1..10)))
  r.prizes << p
end

100.times do
  t = Ticket.new :email => Faker::Internet.email
  r.tickets << t
end



