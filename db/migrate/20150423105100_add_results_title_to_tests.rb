class AddResultsTitleToTests < ActiveRecord::Migration
  def change
    add_column :tests, :results_title, :string
    Test.add_translation_fields!(
      results_title: :string
    )
  end
end
