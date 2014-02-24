FactoryGirl.define do
  sequence(:name) { |n| "name#{n}" }
  sequence(:cost) { |n| n }
  sequence(:price) { |n| n }
  sequence(:email) { |n| "email#{n}@gmail.com" }
  sequence(:content) { |n| "Blah blah #{n}" }

  factory :performer do
    name
    user
    genre "Moon Rock"
    soundcloud_url "https://soundcloud.com/chancetherapper/sets/chance-the-rapper-acid-rap"
    description "Rad time"
    price
    sequence(:recipient_id) { |n| n }
  end

  factory :user do
    email
    stripe_customer_id nil
  end

  factory :booking do
    performer
    user
    cost
    event_date Date.today
    active true
  end

  factory :review do
    user
    performer
    content
  end

  factory :comments do
    user
    booking
    content
  end
end
