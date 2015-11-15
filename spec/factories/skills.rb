FactoryGirl.define do
  factory :skill do
    sequence :name do |n| "skill-#{n}" end
  end
end
