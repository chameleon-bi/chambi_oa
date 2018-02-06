class CreateExternalLinks < ActiveRecord::Migration[4.2]
  def change
    create_table :optimadmin_external_links do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
