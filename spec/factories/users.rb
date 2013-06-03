FactoryGirl.define do
  factory :user do
    sequence(:name) { |i| "User #{i}" }

    factory :user_with_posts do
      ignore { posts_count 5 }

      after(:create) do |user, evaluator|
        FactoryGirl.create_list(:post, evaluator.posts_count, user: user)
      end
    end
  end
end
