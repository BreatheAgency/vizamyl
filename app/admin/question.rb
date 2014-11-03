ActiveAdmin.register Question do
  config.paginate = false
  config.filters = false

  belongs_to :question_set

  controller do
    def permitted_params
      params.permit!
    end
  end

  form do |f|
    f.translated_inputs switch_locale: true do |t|
      t.input :body, as: :html_editor
    end
    f.actions
  end

  show do
    attributes_table do
      row :body
    end
  end
end
