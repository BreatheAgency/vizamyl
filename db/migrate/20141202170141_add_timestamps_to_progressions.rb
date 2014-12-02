class AddTimestampsToProgressions < ActiveRecord::Migration
  def change
    change_table :progressions do |t|
      t.timestamps
    end
  end
end
