ActiveAdmin.register Interactive do
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
    f.translated_inputs switch_locale: true do |t|
      t.input :title
      t.input :body, as: :html_editor
    end
    f.inputs do
      f.input :sources_raw, label: 'Sources'
    end
    f.actions
  end

  show do
    attributes_table do
      row :title
      row :body
      row :sources do
        interactive.sources_raw
      end
    end
  end
end
