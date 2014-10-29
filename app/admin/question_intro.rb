ActiveAdmin.register QuestionIntro do
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

  show do
    attributes_table do
      row :title
    end
  end
end
