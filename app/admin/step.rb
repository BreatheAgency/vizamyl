ActiveAdmin.register Step do
  config.sort_order = 'position_asc'
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
    sortable_handle_column
    column :position
    column :type
    column :title do |step|
      link_to(step.type, polymorphic_url([:admin, chapter, step.page]))
    end
    translation_status_flags
  end
end
