FactoryGirl.define do
  factory :image, class: 'Optimadmin::Image' do
    name 'landscape image'
    image { File.open(File.join(Rails.root, 'spec/support/images/landscape_image.jpg')) }
  end
end
