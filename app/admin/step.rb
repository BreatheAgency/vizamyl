ActiveAdmin.register Step do
  config.sort_order = 'position_asc'
  config.paginate = false
  config.filters = false
  config.clear_action_items!

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
    column :id do |step|
      link_to(step.page.page_id, polymorphic_url([:admin, chapter, step.page]))
    end
    column :page do |step|
      link_to(step.page.title, polymorphic_url([:admin, chapter, step.page]))
    end
    column :visible
    column :page_type
  end

end
