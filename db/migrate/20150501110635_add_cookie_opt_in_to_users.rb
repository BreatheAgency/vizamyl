class AddCookieOptInToUsers < ActiveRecord::Migration
  def change
    add_column :users, :cookies_opt_in, :boolean, default: false
  end
end
