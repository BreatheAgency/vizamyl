class CreateInteractives < ActiveRecord::Migration
  def up
    create_table :interactives do |t|
      t.string :page_id
      t.string :title
      t.text :body
      t.string :subject_area
      t.text :sources, array: true
    end
    Interactive.create_translation_table!(
      title: { type: :string },
      body: { type: :text },
      subject_area: { type: :string }
    )
  end

  def down
    drop_table :interactives
    Interactive.drop_translation_table!
  end
end
