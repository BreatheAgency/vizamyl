class AddVisibleToSteps < ActiveRecord::Migration
  def change
    add_column :steps, :visible, :boolean, default: false
  end
end
