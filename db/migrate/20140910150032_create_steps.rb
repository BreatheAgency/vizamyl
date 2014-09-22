class CreateSteps < ActiveRecord::Migration
  def up
    create_table :steps do |t|
      t.integer :chapter_id
      t.string :type
      t.string :title
      t.integer :position
    end
    Step.create_translation_table! title: { type: :string, null: false }
  end

  def down
    drop_table :steps
    Step.drop_translation_table!
  end
end
