class I18n::Backend::ActiveRecord::Translation < ::ActiveRecord::Base
  def value_raw
    self.value
  end

  def value_raw=(value)
    self.value = value
  end
end


ActiveAdmin.register Translation, namespace: :content do
  filter :locale, as: :select, collection: I18n.available_locales
  filter :key

  controller do
    def permitted_params
      params.permit!
    end
  end

  index do
    column :locale
    column :key
    column :value_raw
    actions
  end

  form do |f|
    f.inputs do
      f.input :locale, as: :select, collection: I18n.available_locales
      f.input :key
      f.input :value_raw, as: :text, label: 'Value'
      # f.input :value_raw, as: :html_editor
    end
    f.actions
  end

  show title: :key do
    attributes_table do
      row :locale
      row :key
      row :value_raw
    end
  end
end
