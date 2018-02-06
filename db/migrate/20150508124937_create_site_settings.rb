class CreateSiteSettings < ActiveRecord::Migration[4.2]
  def change
    create_table 'optimadmin_site_settings', force: true do |t|
      t.string 'key', unique: true
      t.string 'value'
      t.string 'environment'
    end
    %w[production development].each do |env|
      Optimadmin::SiteSetting.create(key: 'Name', value: 'optimadmin', environment: env)
      Optimadmin::SiteSetting.create(key: 'Meta - Title', value: 'optimadmin', environment: env)
      Optimadmin::SiteSetting.create(key: 'Meta - Description', value: 'optimadmin meta description', environment: env)
      Optimadmin::SiteSetting.create(key: 'Forms - Default Email', value: 'support@optimised.today', environment: env)
      Optimadmin::SiteSetting.create(key: 'Social - Twitter', value: '#', environment: env)
      Optimadmin::SiteSetting.create(key: 'Social - Facebook', value: '#', environment: env)
      Optimadmin::SiteSetting.create(key: 'Social - LinkedIn', value: '#', environment: env)
      Optimadmin::SiteSetting.create(key: 'Social - YouTube', value: '#', environment: env)
      Optimadmin::SiteSetting.create(key: 'Social - Instagram', value: '#', environment: env)
      Optimadmin::SiteSetting.create(key: 'Social - Phone', value: '#', environment: env)
      Optimadmin::SiteSetting.create(key: 'Social - Email', value: '#', environment: env)
    end
  end
end
