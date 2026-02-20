class AddPrivacyOptInToUsers < ActiveRecord::Migration
  def change
    add_column :users, :privacy_opt_in, :boolean, default: false
  end
end
