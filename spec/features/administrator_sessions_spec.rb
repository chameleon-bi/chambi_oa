require 'rails_helper'

RSpec.feature 'Administrator seessions', type: :feature, administrator: true do
  let(:administrator) { create(:administrator) }

  it 'successfully logs in with username' do
    login(administrator, login_path)
  end

  it 'successfully logs in with email' do
    visit login_path
    fill_in 'login_name', with: administrator.email
    fill_in 'password', with: administrator.password
    submit_login
    expect(current_path).to eq(root_path)
  end

  it 'successfully redirects to requested URL' do
    login(administrator, pages_path)
  end
end
