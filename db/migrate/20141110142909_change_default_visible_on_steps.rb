class ChangeDefaultVisibleOnSteps < ActiveRecord::Migration
  def change
    change_column :steps, :visible, :boolean, default: true
  end
end
