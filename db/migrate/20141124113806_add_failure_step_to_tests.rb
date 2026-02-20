class AddFailureStepToTests < ActiveRecord::Migration
  def change
    add_column :tests, :failure_step_id, :integer
  end
end
