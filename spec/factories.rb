FactoryGirl.define do 
  factory :piece do
  end
  factory :game do
    white_user_id {FactoryGirl.create(:user).id}
    black_user_id {FactoryGirl.create(:user).id}
  end
  factory :user do
    sequence :email do |n|
      "dummyEmail#{n}@gmail.com"
    end
    password "secretPassword"
    password_confirmation "secretPassword"
  end
end


