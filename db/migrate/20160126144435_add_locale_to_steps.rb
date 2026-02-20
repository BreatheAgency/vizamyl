class AddLocaleToSteps < ActiveRecord::Migration
  def self.up
    add_column :steps, :locales, :text, array: true, null: false, default: []
    add_index :steps, :locales, using: 'gin'
    Step.update_all(locales: I18n.available_locales)
  end

  def self.down
    remove_column :steps, :locales
  end
end
