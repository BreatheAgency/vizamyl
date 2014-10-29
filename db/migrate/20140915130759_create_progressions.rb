class CreateProgressions < ActiveRecord::Migration
  def change
    create_table :progressions do |t|
      t.references :user
      t.references :step
      t.float :amount, default: 0
    end
    add_index :progressions, [:step_id, :user_id], unique: true
  end
end
