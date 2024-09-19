FactoryBot.define do
  factory :user do
    email { "user@example.com" }
    password { "password" }
    provider { "google_oauth2" }
  end
end
