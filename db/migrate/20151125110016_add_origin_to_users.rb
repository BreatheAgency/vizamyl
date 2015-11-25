class AddOriginToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :origin, :string, default: 'en', null: false
    User.update_all('locale=origin')
  end

  def self.down
    remove_column :users, :origin
  end
end
