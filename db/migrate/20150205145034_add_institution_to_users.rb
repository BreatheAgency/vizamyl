class AddInstitutionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :institution, :text, default: ''
  end
end
