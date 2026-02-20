class CreateInteractiveSource < ActiveRecord::Migration
  def change
    create_table :interactive_sources do |t|
      t.references :subject, polymorphic: true
      t.string :source
      t.string :label
      t.integer :height
    end
    InteractiveSource.create_translation_table!(
      label: { type: :string }
    )
  end
end
