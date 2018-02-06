FactoryGirl.define do
  factory :link, class: 'Optimadmin::Link' do
    #menu_item
    menu_resource_type 'Optimadmin::ExternalLink'
    association :menu_resource, factory: :external_link
  end
end
