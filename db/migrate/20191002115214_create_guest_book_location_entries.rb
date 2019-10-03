class CreateGuestBookLocationEntries < ActiveRecord::Migration[6.0]
  def change
    create_join_table :people, :locations do |t|
      t.index [:person_id, :location_id]
    end
  end
end
