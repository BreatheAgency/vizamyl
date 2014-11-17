class CreateQuestionRound < ActiveRecord::Migration
  def change
    create_table :question_rounds do |t|
      t.references :subject, polymorphic: true
    end
  end
end
