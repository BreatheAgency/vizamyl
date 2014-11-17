class CreateQuestions < ActiveRecord::Migration
  def up
    create_table :questions do |t|
      t.text :body
      t.boolean :correct, default: false
      t.references :question_set
    end
    if defined?(Question)
      Question.create_translation_table!(
        body: { type: :text }
      )
    end
    create_table :question_sets do |t|
      t.text :title
      t.references :subject, polymorphic: true
    end
    if defined?(QuestionSet)
      QuestionSet.create_translation_table!(
        title: { type: :text }
      )
    end
  end

  def down
    drop_table :questions
    Question.drop_translation_table! if defined?(Question)
    drop_table :question_sets
    QuestionSet.drop_translation_table! if defined?(QuestionSet)
  end
end
