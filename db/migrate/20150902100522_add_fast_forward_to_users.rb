class AddFastForwardToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fast_forward, :boolean, default: false
  end
end
