ActiveAdmin.register Image do
  config.paginate = false
  config.filters = false

  belongs_to :chapter, polymorphic: true
  sortable

  controller do
    def permitted_params
      params.permit!
    end
  end

  form do |f|
    f.translated_inputs 'Translated fields', switch_locale: true do |t|
      t.input :title
      t.input :source
    end
    f.actions
  end

  show do
    attributes_table do
      row :title
      row :source do |image|
        image_tag(image.source)
      end
    end
  end
end
