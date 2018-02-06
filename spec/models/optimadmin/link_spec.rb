# Basic model spec
# Inspired by https://gist.github.com/kyletcarlson/6234923

require 'rails_helper'
#  rspec --tag 'link'
module Optimadmin
  RSpec.describe Link, type: :model, link: true do
    describe 'validations', :validation do
      subject(:link) { build(:link) }
      it { should validate_presence_of(:menu_resource_type) }
      it { should validate_presence_of(:menu_resource_id) }
    end

    describe 'associations', :association do
      it { should belong_to(:menu_resource) }
      it { should have_one(:menu_item) }
    end

    describe 'public class methods' do
      let(:link) { create(:link) }

      context 'responds to its methods' do
        it { expect(Optimadmin::Link).to respond_to(:related_menu_items) }
      end

      context 'executes methods correctly' do
        context 'self.related_menu_items' do
          it 'returns hash of menu items' do
            # TODO
          end
        end
      end
    end
  end
end
