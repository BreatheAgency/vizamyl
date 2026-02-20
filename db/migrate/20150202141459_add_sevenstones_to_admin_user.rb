class AddSevenstonesToAdminUser < ActiveRecord::Migration
  def change
    add_column :admin_users, :sevenstones, :boolean, default: false
  end
end
