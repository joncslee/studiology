class ChangeBuyUrlLength < ActiveRecord::Migration
  def up
    change_column :gear, :buy_url, :string, :limit => 300
  end

  def down
    change_column :gear, :buy_url, :string
  end
end
