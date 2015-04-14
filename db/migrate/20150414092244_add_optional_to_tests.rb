class AddOptionalToTests < ActiveRecord::Migration
  def change
    add_column :tests, :optional, :boolean, default: false
  end
end
