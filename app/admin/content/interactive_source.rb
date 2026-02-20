ActiveAdmin.register InteractiveSource, namespace: :content do
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
    column :label
    column :height
    actions
  end

  form do |f|
    f.inputs do
      f.input :label
      f.input :source
      f.input :height
    end
    f.actions
  end

  show do
    attributes_table do
      row :label
      row :source do |image|
        image_tag("//#{Rails.application.secrets.content_host}/interactives/#{image.source}.jpg")
      end
      row :height
    end
  end
end
