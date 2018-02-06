FactoryGirl.define do
  factory :module_page, class: 'Optimadmin::ModulePage' do
    name 'Home'
    route 'root_url'
  end
end
