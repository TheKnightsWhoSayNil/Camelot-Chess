FactoryGirl.define do
  factory :game, class: Game do
    name 'example game'
    association :user
  end

  factory :white_game, class: Game do
    name 'example game'
    id 1
    white_player_id 1
  end

  factory :user do
    sequence :email do |n|
      "someone#{n}@example.com"
    end

    password '123123'
  end

  factory :user_black do
    sequence :email do |n|
      "someone#{n}@example.com"
    end
    id 2

    password '123123'
  end
end
