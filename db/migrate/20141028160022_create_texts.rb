class CreateTexts < ActiveRecord::Migration
  def up
    create_table :texts do |t|
      t.string :page_id
      t.string :title
      t.text :body
      t.string :subject_area
    end
    Text.create_translation_table!(
      title: { type: :string },
      body: { type: :text },
      subject_area: { type: :string }
    )
  end

  def down
    drop_table :texts
    Text.drop_translation_table!
  end
end
