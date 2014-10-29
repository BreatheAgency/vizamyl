class CreateInteractiveQuestions < ActiveRecord::Migration
  def up
    create_table :interactive_questions do |t|
      t.string :title
      t.string :subject_area
    end
    InteractiveQuestion.create_translation_table!(
      title: { type: :string, null: false },
      subject_area: { type: :string }
    )
  end

  def down
    drop_table :interactive_questions
    InteractiveQuestion.drop_translation_table!
  end
end
