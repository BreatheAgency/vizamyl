class ChangeQuestions < ActiveRecord::Migration
  def up
    drop_table :questions
    drop_table :question_translations unless !ActiveRecord::Base.connection.table_exists? 'question_translations'
    drop_table :question_sets
    drop_table :question_set_translations unless !ActiveRecord::Base.connection.table_exists? 'question_set_translations'

    create_table :answers do |t|
      t.text :body
      t.boolean :correct, default: false
      t.references :question
    end
    Answer.create_translation_table!(
      body: { type: :text }
    )
    create_table :questions do |t|
      t.text :title
      t.references :question_round
    end
    Question.create_translation_table!(
      title: { type: :text }
    )
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
