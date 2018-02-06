require 'rails_helper'

RSpec.feature 'Menu items', type: :feature, menu_items: true do
  let(:administrator) { create(:administrator) }
  let!(:menu_item) { create(:menu_item) }
  let!(:external_link) { create(:external_link) }
  let!(:module_page) { create(:module_page) }

  it 'successfully lists menu items' do
    login(administrator, menu_items_path)
    expect(page).to have_text(menu_item.name)
  end

  it 'successfully creates new menu items', js: true do
    login(administrator, menu_items_path)
    create_menu_item
  end

  it 'successfully validates new menu items', js: true do
    login(administrator, menu_items_path)
    first('.action-button').click
    expect(current_path).to eq(new_menu_item_path)
    select 'External Link', from: 'menu_item_link_attributes_menu_resource_type'
    find('[name=commit]').click
    expect(current_path).to eq(menu_items_path)
    expect(page).to have_text('errors prohibited this menu item from being saved')
  end

  it 'successfully edits menu items', js: true do
    login(administrator, menu_items_path)
    create_menu_item
    click_on 'Another menu item'
    expect(current_path).to eq(edit_menu_item_path(2))
    fill_in 'menu_item_name', with: 'Another menu item modified'
    find('[name=commit]').click
    expect(current_path).to eq(menu_items_path)
    expect(page).to have_text('Another menu item modified')
  end

  it 'successfully validates edit menu items', js: true do
    login(administrator, menu_items_path)
    create_menu_item
    click_on 'Another menu item'
    expect(current_path).to eq(edit_menu_item_path(2))
    fill_in 'menu_item_name', with: ''
    find('[name=commit]').click
    expect(current_path).to eq(menu_item_path(2))
    expect(page).to have_text('error prohibited this menu item from being saved')
  end

  private

  def create_menu_item
    fill_in_menu_item_form
    find('[name=commit]').click
    expect(current_path).to eq(menu_items_path)
    expect(page).to have_text('Another menu item')
  end

  def fill_in_menu_item_form
    first('.action-button').click
    expect(current_path).to eq(new_menu_item_path)
    fill_in 'menu_item_name', with: 'Another menu item'
    select 'External Link', from: 'menu_item_link_attributes_menu_resource_type'
    select external_link.name, from: 'menu_item_link_attributes_menu_resource_id'
  end
end
