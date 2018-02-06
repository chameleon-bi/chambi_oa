# Basic model spec
# Inspired by https://gist.github.com/kyletcarlson/6234923

require 'rails_helper'
#  rspec --tag 'menu_item'
module Optimadmin
  RSpec.describe MenuItem, type: :model, menu_item: true do
    describe 'validations', :validation do
      subject(:menu_item) { build(:menu_item) }
      it { should validate_presence_of(:menu_name) }
      it { should validate_length_of(:menu_name).is_at_most(100) }
      it { should validate_presence_of(:name) }
      it { should validate_length_of(:name).is_at_most(100) }
      it { should validate_length_of(:title_attribute).is_at_most(100) }
      it { should accept_nested_attributes_for(:link) }
    end

    describe 'associations', :association do
      it { should belong_to(:link).dependent(:destroy) }
    end

    context 'callbacks' do
      # http://guides.rubyonrails.org/active_record_callbacks.html
      # https://github.com/beatrichartz/shoulda-callback-matchers/wiki
      let(:menu_item) { create(:menu_item) }

      it { expect(menu_item).to callback(:set_position).before(:create) }
      it { expect(menu_item).to callback(:check_title_attr).before(:save) }
      it { expect(menu_item).to callback(:check_last_external_link).before(:destroy) }
    end

    describe 'public class methods' do
      let(:menu_item) { create(:menu_item) }

      context 'responds to its methods' do
        it { expect(Optimadmin::MenuItem).to respond_to(:presenter) }
      end

      context 'executes methods correctly' do
        context 'self.presenter' do
          it 'returns presenter' do
            expect(Optimadmin::MenuItem.presenter).to eq(MenuItemPresenter)
          end
        end
      end
    end
  end
end
