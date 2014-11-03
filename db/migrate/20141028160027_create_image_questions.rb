class CreateImageQuestions < ActiveRecord::Migration
  def up
    create_table :image_questions do |t|
      t.string :page_id
      t.string :title
      t.string :subject_area
    end
    ImageQuestion.create_translation_table!(
      title: { type: :string },
      subject_area: { type: :string }
    )
  end

  def down
    drop_table :image_questions
    ImageQuestion.drop_translation_table!
  end
end
