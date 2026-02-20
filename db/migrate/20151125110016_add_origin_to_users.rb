class AddOriginToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :origin, :string, default: 'EN', null: false
    User.update_all('origin=locale')
    User.where(origin: 'en-gb').update_all(origin: 'gb')
    User.where(origin: 'de-at').update_all(origin: 'at')
  end

  def self.down
    remove_column :users, :origin
  end
end
