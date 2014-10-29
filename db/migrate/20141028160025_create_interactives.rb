class CreateInteractives < ActiveRecord::Migration
  def up
    create_table :interactives do |t|
      t.string :title
      t.string :subject_area
    end
    Interactive.create_translation_table!(
      title: { type: :string, null: false },
      subject_area: { type: :string }
    )
  end

  def down
    drop_table :interactives
    Interactive.drop_translation_table!
  end
end
