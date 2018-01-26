class CreateWebsites < ActiveRecord::Migration[5.1]
  def change
    create_table :websites do |t|
      t.string :domain, null: false
      t.integer :num_external_links, null: false
      t.integer :num_internal_links, null: false
    end

    add_index :websites, :domain, unique: true
  end
end
