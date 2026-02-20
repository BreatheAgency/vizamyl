class NullableSalutationOnUser < ActiveRecord::Migration
  def change
    change_column :users, :salutation, :string, null: true
  end
end
