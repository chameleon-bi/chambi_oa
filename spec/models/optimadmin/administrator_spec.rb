# Basic model spec
# Inspired by https://gist.github.com/kyletcarlson/6234923

require 'rails_helper'
#  rspec --tag 'administrator'
module Optimadmin
  RSpec.describe Administrator, type: :model, administrator: true do
    describe 'validations', :validation do
      subject(:administrator) { build(:administrator) }
      it { should have_secure_password }
      it { should validate_presence_of(:role) }
      it { should validate_presence_of(:username) }
      it { should validate_uniqueness_of(:username) }
      it { should validate_presence_of(:email) }
      it { should validate_uniqueness_of(:email) }
    end

    context 'callbacks' do
      # http://guides.rubyonrails.org/active_record_callbacks.html
      # https://github.com/beatrichartz/shoulda-callback-matchers/wiki
      let(:administrator) { create(:administrator) }

      it { expect(administrator).to callback(:generate_auth_token).before(:create) }
    end
  end
end
