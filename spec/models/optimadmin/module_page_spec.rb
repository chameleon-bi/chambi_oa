# Basic model spec
# Inspired by https://gist.github.com/kyletcarlson/6234923

require 'rails_helper'
#  rspec --tag 'module_page'
module Optimadmin
  RSpec.describe ModulePage, type: :model, module_page: true do
    describe 'validations', :validation do
      subject(:module_page) { build(:module_page) }
      it { should validate_presence_of(:name) }
      it { should validate_uniqueness_of(:name).case_insensitive }
      it { should validate_presence_of(:route) }
      it { should validate_uniqueness_of(:route).case_insensitive }
    end

    describe 'public instance methods' do
      let(:module_page) { create(:module_page) }

      context 'responds to its methods' do
        it { expect(module_page).to respond_to(:child_menu_items) }
      end

      context 'executes methods correctly' do
        context '#child_menu_items' do
          it 'returns hash of descendants' do
            # TODO
          end
        end
      end
    end
  end
end
