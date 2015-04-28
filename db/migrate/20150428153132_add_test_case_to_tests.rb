class AddTestCaseToTests < ActiveRecord::Migration
  def change
    add_column :tests, :test_case, :boolean, default: false
  end
end
