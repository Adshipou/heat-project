FactoryBot.define do
  factory :member do
    member_name { "John Doe" }
    member_points { 100 }
    executive_status { false }
  end
end
