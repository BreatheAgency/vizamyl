ActiveAdmin.register User do
  actions :all, except: [:new, :destroy]
  config.filters = false

  controller do
    def permitted_params
      params.permit!
    end
  end

  scope :all, default: true
  I18n.available_locales.map.each do |locale|
    scope locale do |user|
      user.where(locale: locale)
    end
  end

  index do
    selectable_column
    column :id
    column :locale
    column :email
    column(:progress) {|model| "#{model.progress}%" }
    # column(:completed) { |model| model['completed'] ? status_tag( 'yes', :ok )  : status_tag( 'no', :ok ) }
    actions
  end

  form do |f|
    f.inputs 'Details' do
      f.input :email
      f.input :locale, collection: I18n.available_locales
      f.input :created_at, disabled: true, as: :date_select
    end
    f.actions
  end

  show title: :email do |user|
    attributes_table do
      row :id
      row :email
      row(:progress) {|model| "#{model.progress}%" }
      # row(:completed) { |model| model['completed'] ? status_tag( 'yes', :ok )  : status_tag( 'no', :ok ) }
    end
  end
end
