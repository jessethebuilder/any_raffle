module RequestsHelper
  def fill_in_valid_raffle
    visit '/raffles/new'
    fill_in 'Title', with: Faker::Commerce.product_name
    # find(:css, "textarea[id='raffle_description']").set Faker::Lorem.paragraphs(paragraph_count = Random.rand(1..10)).join('<br><br>')
    within('#raffle_description_group') do
      # fill_in 'Description', with: Faker::Lorem.paragraphs(paragraph_count = Random.rand(1..10)).join('<br><br>')
    end
    # fill_in '#raffle_description', with: Faker::Lorem.paragraphs(paragraph_count = Random.rand(1..10)).join('<br><br>')
    # fill_in '#raffle_description', with: Faker::Lorem.paragraphs(paragraph_count = Random.rand(1..10)).join('<br><br>')
    fill_in 'Ticket price', with: Random.rand(0..1000.0)

    case Random.rand(1..3)
      when 1
        fill_in 'Total number of tickets to sell', with: Random.rand(1..10000)
      when 2
        fill_in 'End time', with: Time.now + Random.rand(1..1000).hours
      when 3
        fill_in 'Total number of tickets to sell', with: Random.rand(1..10000)
        fill_in 'End time', with: Time.now + Random.rand(1..1000).hours
    end
  end

  def manual_sign_in
    pw = '!!@dnsrpollo9833741'
    user = create(:user, :password => pw)
    visit '/users/sign_in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: pw
    click_button 'Sign in'
    user
  end
end