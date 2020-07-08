class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :city_or_state, :string
    add_column :users, :primary_specialty, :string
  end
end
