ActiveAdmin.register Step, namespace: :content do
  actions :all, except: [:new, :destroy]
  config.sort_order = 'position_asc'
  config.paginate = false
  config.filters = false

  belongs_to :chapter, polymorphic: true

  controller do
    def permitted_params
      params.permit!
    end
  end

  index do
    column :position
    column :id
    column :page do |step|
      link_to(step.page.title, polymorphic_url([:content, chapter, step.page]))
    end
    column(:visible) { |model| model['visible'] ? status_tag( 'yes', :ok )  : status_tag( 'no', :ok ) }
    column :page_type
    actions
  end

  form do |f|
    f.inputs do
      f.input :visible
    end
    f.actions
  end

end
