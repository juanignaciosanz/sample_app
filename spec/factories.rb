#Just for one testing should do the job
#FactoryGirl.define do
#  factory :user do
#    name     "Michael Hartl"
#    email    "michael@example.com"
#    password "foobar"
#    password_confirmation "foobar"
#  end
#end

FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}   
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end

    factory :password_reset do
      password_reset_sent_at Time.zone.now
    end
  end

  factory :micropost do
    content "Lorem ipsum"
    user
  end
end