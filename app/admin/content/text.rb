ActiveAdmin.register Text, namespace: :content do
  config.sort_order = 'id_asc'
  actions :all, except: [:new, :destroy]
  config.paginate = false
  config.filters = false

  belongs_to :chapter, polymorphic: true

  controller do
    def permitted_params
      params.permit!
    end
  end

  index do
    column :page_id do |text|
      link_to(text.page_id, content_chapter_text_path(chapter, text))
    end
    column :title do |text|
      link_to(text.title, content_chapter_text_path(chapter, text))
    end
    actions
  end

  form do |f|
    f.inputs do
      f.input :title, as: :html_editor
      f.input :body, as: :html_editor
      f.input :subject_area
      f.input :abbreviations, as: :html_editor
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
