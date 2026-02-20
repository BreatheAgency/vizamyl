class AddFourBBooleansToUsers < ActiveRecord::Migration
  def change
    add_column :users, :failed_round_one, :boolean, default: false
    add_column :users, :failed_round_two, :boolean, default: false
    add_column :users, :passed_round_one, :boolean, default: false
    add_column :users, :passed_round_two, :boolean, default: false
  end
end
