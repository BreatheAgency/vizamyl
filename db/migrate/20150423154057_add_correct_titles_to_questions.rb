class AddCorrectTitlesToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :correct_title, :string
    add_column :questions, :incorrect_title, :string
    Question.add_translation_fields!(
      correct_title: :string,
      incorrect_title: :string,
    )
  end
end
