class AddSuccessAndFailureStepsToImageQuestions < ActiveRecord::Migration
  def change
    add_column :image_questions, :failure_step_id, :integer
  end
end
