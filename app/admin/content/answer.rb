ActiveAdmin.register Answer, namespace: :content do
  config.paginate = false
  config.filters = false

  belongs_to :question

  controller do
    def permitted_params
      params.permit!
    end
  end

  form do |f|
    f.inputs do
      f.input :correct
      f.input :body, as: :html_editor
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
