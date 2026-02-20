class RenameSevenstonesOnAdminUsers < ActiveRecord::Migration
  def change
    rename_column :admin_users, :sevenstones, :content_admin
  end
end
