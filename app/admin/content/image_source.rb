ActiveAdmin.register ImageSource, namespace: :content do
  config.sort_order = 'id_asc'
  actions :all, except: [:new, :destroy]
  config.paginate = false
  config.filters = false

  # belongs_to :subject, polymorphic: true

  controller do
    def permitted_params
      params.permit!
    end
  end

  index do
    column :id
    column :source
    # translation_status_flags
    actions
  end

  form do |f|
    f.inputs do
      f.input :source
    end
    f.actions
  end

  show do
    attributes_table do
      row :source do |image|
        image_tag("//#{Rails.application.secrets.content_host}/images/#{image.source}.jpg")
      end
    end
  end
end
