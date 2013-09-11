class CreateStudios < ActiveRecord::Migration
  def change
    create_table :studios do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
