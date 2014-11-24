ActiveAdmin.register Interactive do
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
    column :page_id do |interactive|
      link_to(interactive.page_id, admin_chapter_interactive_path(chapter, interactive))
    end
    column :title do |interactive|
      link_to(interactive.title, admin_chapter_interactive_path(chapter, interactive))
    end
    # translation_status_flags
    actions
  end

  form do |f|
    f.translated_inputs switch_locale: true do |t|
      t.input :title
      t.input :body, as: :html_editor
      t.input :subject_area
    end
    f.has_many :interactive_sources, allow_destroy: true do |ff|
      ff.translated_inputs switch_locale: true do |tt|
        tt.input :label
      end
      ff.inputs do
        ff.input :source
        ff.input :height
      end
    end
    f.actions
  end

  show title: :page_id do
    attributes_table do
      row :title
      row :body
      row :subject_area
    end
    panel 'Interactive Sources' do
      interactive.interactive_sources.each do |interactive_source|
        attributes_table_for interactive_source do
          row :id do |interactive_source|
            link_to(interactive_source.id, admin_interactive_source_path(interactive_source))
          end
          row :label
          row :source
          row :height
        end
      end
    end
  end
end
