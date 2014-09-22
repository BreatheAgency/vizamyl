ActiveAdmin.register Step do
  config.sort_order = 'position_asc'
  config.paginate = false
  config.filters = false

  # permit_params translations_attributes: [:id, :title, :locale, :_destroy]
  belongs_to :chapter, polymorphic: true
  sortable

  controller do
    def permitted_params
      params.permit!
    end
  end

  index do
    sortable_handle_column
    column :title do |step|
      link_to(step.type, admin_chapter_step_path(chapter, step))
    end
    translation_status_flags
    column :position
    column :type
    actions
  end

  form do |f|
    f.translated_inputs 'Translated fields', switch_locale: true do |t|
      t.input :title
    end
    f.actions
  end

  show do
    attributes_table do
      # row :title
      row :chapter
    end
  end
end
