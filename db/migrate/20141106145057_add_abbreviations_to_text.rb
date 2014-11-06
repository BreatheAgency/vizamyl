class AddAbbreviationsToText < ActiveRecord::Migration
  def up
    add_column :texts, :abbreviations, :text
    Text.add_translation_fields! abbreviations: :text
  end

  def down
    remove_column :text_translations, :abbreviations
    remove_column :texts, :abbreviations
  end
end
