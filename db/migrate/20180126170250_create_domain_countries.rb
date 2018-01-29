class CreateDomainCountries < ActiveRecord::Migration[5.1]
  def change
    create_table :domain_countries do |t|
      t.string :domain, null: false
      t.string :country, null: false
      t.float :percentage, null: false
    end

    add_index :domain_countries, [:domain, :country], unique: true
  end
end
