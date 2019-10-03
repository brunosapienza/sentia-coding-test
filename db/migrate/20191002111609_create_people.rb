class CreatePeople < ActiveRecord::Migration[6.0]
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.string :species
      t.string :weapon
      t.string :vehicle
    end
  end
end
