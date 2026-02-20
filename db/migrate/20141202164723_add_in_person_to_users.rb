class AddInPersonToUsers < ActiveRecord::Migration
  def change
    add_column :users, :in_person, :boolean, default: false
  end
end
