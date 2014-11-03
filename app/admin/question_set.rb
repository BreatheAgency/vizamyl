ActiveAdmin.register QuestionSet do
  config.paginate = false
  config.filters = false

  controller do
    belongs_to :subject, polymorphic: true
    def permitted_params
      params.permit!
    end
  end

  form do |f|
    f.translated_inputs switch_locale: true do |t|
      t.input :title, as: :html_editor
    end
    f.actions
  end

  show do
    attributes_table do
      row :title
    end
  end
end
