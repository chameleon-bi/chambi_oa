FactoryGirl.define do
  factory :document, class: 'Optimadmin::Document' do
    name 'landscape image'
    document { File.open(File.join(Rails.root, 'spec/support/images/landscape_image.jpg')) }
  end
end
