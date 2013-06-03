FactoryGirl.define do
  factory :post do
    sequence(:title) { |i| "Title #{i}" }
    sequence(:content) { |i| "Content #{i}" }
    user
  end
end
