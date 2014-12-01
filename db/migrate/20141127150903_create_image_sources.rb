class CreateImageSources < ActiveRecord::Migration
  def change
    create_table :image_sources do |t|
      t.references :subject, polymorphic: true
      t.string :source
    end
    ImageSource.create_translation_table!(
      source: { type: :string }
    )
  end
end
