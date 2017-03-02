FactoryGirl.define do 
  factory :game do
    association :white_user, factory: :user
  end

  factory :game_white_player, class: Game do
    name 'example game'
    white_player_id 1
  end

  factory :piece do
    association :user_id
    association :game
  end

  factory :user do
    sequence :email do |n|
      "dummyEmail#{n}@gmail.com"
    end
    password "secretPassword"
    password_confirmation "secretPassword"
  end
end

  


