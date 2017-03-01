FactoryGirl.define do
  factory :game do
    id 1
    white_user_id 1
  end

  factory :game_white_player, class: Game do
    name 'example game'
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
