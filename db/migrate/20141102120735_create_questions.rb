class CreateQuestions < ActiveRecord::Migration
  def up
    create_table :questions do |t|
      t.text :body
      t.boolean :correct, default: false
      t.references :question_set
    end
    Question.create_translation_table!(
      body: { type: :text }
    )
    create_table :question_sets do |t|
      t.text :title
      t.references :subject, polymorphic: true
    end
    QuestionSet.create_translation_table!(
      title: { type: :text }
    )
  end

  def down
    drop_table :questions
    Question.drop_translation_table!
    drop_table :question_sets
    QuestionSet.drop_translation_table!
  end
end
