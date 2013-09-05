class CreateGear < ActiveRecord::Migration
  def self.up
    create_table :gear do |t|
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :gear
  end
end
