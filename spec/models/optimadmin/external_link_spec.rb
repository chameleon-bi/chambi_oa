# Basic model spec
# Inspired by https://gist.github.com/kyletcarlson/6234923

require 'rails_helper'
#  rspec --tag 'external_link'
module Optimadmin
  RSpec.describe ExternalLink, type: :model, external_link: true do
    describe 'validations', :validation do
      subject(:external_link) { build(:external_link) }
      it { should validate_presence_of(:name) }
      it { should validate_uniqueness_of(:name) }
    end

    describe 'associations', :association do
      it { should respond_to(:menu_items) }
    end
  end
end
