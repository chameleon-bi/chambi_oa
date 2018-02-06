class CreateLinks < ActiveRecord::Migration[4.2]
  def change
    create_table :optimadmin_links do |t|
      t.string :menu_resource_type
      t.integer :menu_resource_id

      t.timestamps null: false
    end
  end
end
