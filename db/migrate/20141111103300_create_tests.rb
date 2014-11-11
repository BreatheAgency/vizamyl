class CreateTests < ActiveRecord::Migration
  def up
    create_table :tests do |t|
      t.string :page_id
      t.string :title
      t.string :subject_area
    end
    Test.create_translation_table!(
      title: { type: :string },
      subject_area: { type: :string }
    )
  end

  def down
    drop_table :tests
    Test.drop_translation_table!
  end
end
