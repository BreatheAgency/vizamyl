class AddTypeToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :test_case, :boolean, default: false
  end
end
