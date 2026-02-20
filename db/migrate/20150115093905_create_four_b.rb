class CreateFourB < ActiveRecord::Migration
  def up
    create_table :four_bs do |t|
      t.string :page_id
      t.string :title
      t.string :subject_area
    end
    FourB.create_translation_table!(
      title: { type: :string },
      subject_area: { type: :string }
    )
  end

  def down
    drop_table :four_bs
    FourB.drop_translation_table!
  end
end
