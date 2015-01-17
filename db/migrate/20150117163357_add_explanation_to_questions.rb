class AddExplanationToQuestions < ActiveRecord::Migration
  def up
    add_column :questions, :explanation_source, :text
    Question.add_translation_fields! explanation_source: :text
  end

  def down
    remove_column :question_translations, :explanation_source
    remove_column :questions, :explanation_source
  end
end
