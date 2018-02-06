# Login methods for administrator
module LoginMacros
  def login(administrator, initial_path)
    visit initial_path
    fill_in_details(administrator)
    check_path(initial_path)
  end

  def submit_login
    click_button 'Log In'
    expect(page).to have_text('Logged in!')
  end

  private

  def fill_in_details(administrator)
    fill_in 'login_name', with: administrator.username
    fill_in 'password', with: administrator.password
    submit_login
  end

  def check_path(initial_path)
    if initial_path == login_path
      expect(current_path).to eq(root_path)
    else
      expect(current_path).to eq(initial_path)
    end
  end
end
