class DropOtherQuestionPages < ActiveRecord::Migration
  def up
    drop_table :image_questions
    drop_table :image_question_translations unless !ActiveRecord::Base.connection.table_exists? 'image_question_translations'
    drop_table :interactive_questions
    drop_table :interactive_question_translations unless !ActiveRecord::Base.connection.table_exists? 'interactive_question_translations'
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
