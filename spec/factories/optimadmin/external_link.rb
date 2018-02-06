FactoryGirl.define do
  factory :external_link, class: 'Optimadmin::ExternalLink' do
    sequence(:name) {|n| "http://www.external-link-#{n}.com" }
  end
end
