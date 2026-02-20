class ChangePassFailuresOnUsers < ActiveRecord::Migration
  def change
    remove_column :users, :failed_round_one
    remove_column :users, :failed_round_two
    remove_column :users, :passed_round_one
    remove_column :users, :passed_round_two
    add_column :users, :failed_round_one_at, :datetime
    add_column :users, :failed_round_two_at, :datetime
    add_column :users, :passed_round_one_at, :datetime
    add_column :users, :passed_round_two_at, :datetime
  end
end
