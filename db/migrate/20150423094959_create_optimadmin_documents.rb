class CreateOptimadminDocuments < ActiveRecord::Migration[4.2]
  def change
    create_table :optimadmin_documents do |t|
      t.string :name, null: false
      t.string :document, null: false
      t.string :module_name
      t.integer :module_id
      t.timestamps null: false
    end
  end
end
