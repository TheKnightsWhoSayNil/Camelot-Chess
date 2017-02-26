FactoryGirl.define do
  factory :game do
    name 'example game'
  end

  factory :game_white_player, class: Game do
    name 'example game'
    white_player_id 1
  end

  factory :user do
    id 1
    username 'Example name'
  end
end
