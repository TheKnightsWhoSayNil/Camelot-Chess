FactoryGirl.define do
  factory :message do
    content "MyText"
  end
  factory :game do
    association :white_user, factory: :user
  end

  factory :game_white_player, class: Game do
    name 'example game'
    white_player_id 1
  end

  factory :piece do
    association :game
    x_position 0
    y_position 0
    color false
  end

  factory :user do
    sequence :email do |n|
      "randomEmail#{n}@gmail.com"
    end
    password "secretPassword"
    password_confirmation "secretPassword"
  end

  factory :king, parent: :piece do
    piece_type "King"
    x_position 1
    y_position 1
  end

  factory :bishop, parent: :piece do
    piece_type "Bishop"
    x_position 2
    y_position 2
  end
end
