FactoryGirl.define do
  factory :administrator, class: 'Optimadmin::Administrator' do
    sequence(:username) { |n| "administrator#{n}" }
    sequence(:email) { |n| "administrator#{n}@optimised.today" }
    password 'optipoipoip'
    password_confirmation 'optipoipoip'
    role 'master'
  end
end
