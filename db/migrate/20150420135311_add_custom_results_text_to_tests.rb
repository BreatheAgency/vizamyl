class AddCustomResultsTextToTests < ActiveRecord::Migration
  def change
    remove_column :tests, :optional
    add_column :tests, :results_correct, :text
    add_column :tests, :results_incorrect, :text
    Test.add_translation_fields!(
      results_incorrect: :text,
      results_correct: :text
    )
  end
end
