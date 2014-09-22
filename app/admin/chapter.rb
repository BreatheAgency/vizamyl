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
    actions
  end

  sidebar 'Associations', only: [:show, :edit] do
    ul do
      li(link_to('Steps', admin_chapter_steps_path(chapter)))
    end
  end

  form do |f|
    f.translated_inputs 'Translated fields', switch_locale: true do |t|
      t.input :title
    end
    f.actions
  end

  show do
    attributes_table do
      row :title
    end
    panel 'Steps' do
      table_for(chapter.steps) do
        column :id
        column :type do |step|
          link_to(step.type, admin_chapter_steps_path(step))
        end
      end
    end
  end
end
