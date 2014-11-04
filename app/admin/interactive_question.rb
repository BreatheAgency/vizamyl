ActiveAdmin.register InteractiveQuestion do
  actions :all, except: [:new, :destroy]
  config.paginate = false
  config.filters = false

  belongs_to :chapter, polymorphic: true
  sortable

  controller do
    def permitted_params
      params.permit!
    end
  end

  form do |f|
    f.translated_inputs 'Translated fields', switch_locale: true do |t|
      t.input :title
    end
    f.actions
  end

  show title: :page_id do
    attributes_table do
      row :title
    end
  end
end
