ActiveAdmin.register Answer do
  config.paginate = false
  config.filters = false

  belongs_to :question

  controller do
    def permitted_params
      params.permit!
    end
  end

  form do |f|
    f.translated_inputs switch_locale: true do |t|
      t.input :body, as: :html_editor
    end
    f.inputs do
      f.input :correct
    end
    f.actions
  end

  show do
    attributes_table do
      row :body
      row(:correct) { |model| model['correct'] ? status_tag('yes', :ok)  : status_tag('no', :ok) }
    end
  end
end
