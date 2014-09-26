ActiveAdmin.register Video do
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
    end
    f.row :chapter
    f.actions
  end

  show do
    attributes_table do
      row :title
      row :chapter
    end
  end
end
