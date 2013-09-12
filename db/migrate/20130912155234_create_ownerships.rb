class CreateOwnerships < ActiveRecord::Migration
  def change
    create_table :ownerships do |t|
      t.integer :studio_id
      t.integer :gear_id
      t.text :notes

      t.timestamps
    end
  end
end
