FactoryGirl.define do
  factory :menu_item, class: 'Optimadmin::MenuItem' do
    menu_name 'header'
    sequence(:name) {|n| "Link #{n}" }
    sequence(:title_attribute) {|n| "Link title #{n}" }
    link
  end
end
