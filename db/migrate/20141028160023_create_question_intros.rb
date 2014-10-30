class CreateQuestionIntros < ActiveRecord::Migration
  def up
    create_table :question_intros do |t|
      t.string :title
      t.string :subject_area
    end
    QuestionIntro.create_translation_table!(
      title: { type: :string },
      subject_area: { type: :string }
    )
  end

  def down
    drop_table :question_intros
    QuestionIntro.drop_translation_table!
  end
end
