ActiveAdmin.register Chapter do
  config.sort_order = 'position_asc'
  config.filters = false
  sortable

  controller do
    def permitted_params
      params.permit!
    end
  end

  scope :all, default: true
  I18n.available_locales.map.each do |locale|
    scope locale do |chapter|
      chapter.with_translations(locale.to_s)
    end
  end

  index do
    sortable_handle_column
    column :title do |chapter|
      link_to(chapter.title, admin_chapter_path(chapter))
    end
    translation_status_flags
  end

  sidebar 'Associations', only: [:show, :edit] do
    ul do
      li(link_to('Steps', admin_chapter_steps_path(chapter)))
      %i(videos texts images interactives question_intros image_questions interactive_questions).each do |page_type|
        li(link_to(page_type.to_s.titleize, polymorphic_url([:admin, chapter, page_type.to_s.tableize])))
      end
    end
  end

  form do |f|
    f.translated_inputs switch_locale: true do |t|
      t.input :title
    end
    f.actions
  end

  show do
    attributes_table do
      row :title
    end
  end
end
