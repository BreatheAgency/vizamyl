ActiveAdmin.register Text do
  config.sort_order = 'id_asc'
  actions :all, except: [:new, :destroy]
  config.paginate = false
  config.filters = false

  belongs_to :chapter, polymorphic: true
  sortable

  controller do
    def permitted_params
      params.permit!
    end
  end

  index do
    column :page_id do |text|
      link_to(text.page_id, admin_chapter_text_path(chapter, text))
    end
    column :title do |text|
      link_to(text.title, admin_chapter_text_path(chapter, text))
    end
    # translation_status_flags
    actions
  end

  form do |f|
    f.translated_inputs do |t|
      t.input :title
      t.input :body, as: :html_editor
      t.input :subject_area
      t.input :abbreviations, as: :html_editor
    end
    f.actions
  end

  show title: :page_id do
    attributes_table do
      row :title
      row :body
      row :subject_area
      row :abbreviations
    end
  end
end
