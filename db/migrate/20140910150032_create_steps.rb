class CreateSteps < ActiveRecord::Migration
  def up
    create_table :steps do |t|
      t.integer :chapter_id
      t.integer :position
      t.references :page, polymorphic: true
    end
  end

  def down
    drop_table :steps
  end
end
