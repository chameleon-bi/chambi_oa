FactoryGirl.define do
  factory :page do
    title 'page title'
    file { File.open(File.join(Rails.root, 'spec/support/images/landscape_image.jpg')) }
  end
end
