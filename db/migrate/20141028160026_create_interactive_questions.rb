class CreateInteractiveQuestions < ActiveRecord::Migration
  def up
    create_table :interactive_questions do |t|
      t.string :page_id
      t.string :title
      t.string :subject_area
    end
    if defined?(ImageQuestion)
      InteractiveQuestion.create_translation_table!(
        title: { type: :string },
        subject_area: { type: :string }
      )
    end
  end

  def down
    drop_table :interactive_questions
    InteractiveQuestion.drop_translation_table! if defined?(ImageQuestion)
  end
end
