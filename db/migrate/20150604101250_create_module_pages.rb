class CreateModulePages < ActiveRecord::Migration[4.2]
  def change
    create_table :optimadmin_module_pages do |t|
      t.string :name
      t.string :route

      t.timestamps null: false
    end
  end
end
