FactoryGirl.define do
  factory :site_setting, class: 'Optimadmin::SiteSetting' do
    environment "test"
    trait :name do
      key 'Name'
      value 'Site Name'
    end

    trait :email do
      key 'Email'
      value 'support@optimised.today'
    end

    trait :no_environment do
      environment nil
    end

    factory :site_setting_name, traits: [:name]
    factory :site_setting_email, traits: [:email]
    factory :site_setting_no_enviornment, traits: [:no_environment]
  end
end
