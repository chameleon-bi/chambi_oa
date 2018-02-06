# Basic model spec
# Inspired by https://gist.github.com/kyletcarlson/6234923

require 'rails_helper'
#  rspec --tag 'site_setting'
module Optimadmin
  RSpec.describe SiteSetting, type: :model, site_setting: true do
    describe 'validations', :validation do
      subject(:site_setting) { build(:site_setting_name) }
      it { should validate_presence_of(:value) }
      it { should validate_presence_of(:key) }
      it { should validate_uniqueness_of(:key).scoped_to(:environment) }
    end

    context 'callbacks with environment' do
      # http://guides.rubyonrails.org/active_record_callbacks.html
      # https://github.com/beatrichartz/shoulda-callback-matchers/wiki
      let(:site_setting) { create(:site_setting_name) }

      it 'does not set environment' do
        expect(site_setting).to_not callback(:set_environment).before(:save).if(:environment?)
      end
    end

    context 'callbacks without environment' do
      # http://guides.rubyonrails.org/active_record_callbacks.html
      # https://github.com/beatrichartz/shoulda-callback-matchers/wiki
      let(:site_setting) { create(:site_setting_name, :no_environment) }

      it 'sets environment' do
        expect(site_setting).to callback(:set_environment).before(:save)
        expect(site_setting.environment).to eq(Rails.env.to_s)
      end
    end

    describe 'public class methods' do
      context 'responds to its methods' do
        it { expect(Optimadmin::SiteSetting).to respond_to(:current_environment) }
      end

      context 'executes methods correctly' do
        context 'self.current_environment' do
          it 'returns hash of current environment site settings' do
            expect(Optimadmin::SiteSetting.current_environment).to eq(Hash[Optimadmin::SiteSetting.where(environment: Rails.env.to_s).pluck(:key, :value)])
          end
        end
      end
    end
  end
end
