ActiveAdmin.register Video do
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
    f.translated_inputs switch_locale: true do |t|
      t.input :title
      t.input :body, as: :html_editor
      t.input :subject_area
      t.input :source
      t.input :abbreviations, as: :html_editor
    end
    f.inputs do
      f.input :mandatory
    end
    f.actions
  end

  show do
    attributes_table do
      row :title
      row :body
      row :subject_area
      row(:mandatory) { |model| model['mandatory'] ? status_tag( 'yes', :ok )  : status_tag( 'no', :ok ) }
      row :source
      row :abbreviations
    end
  end
end
