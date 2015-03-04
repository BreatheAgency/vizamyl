ActiveAdmin.register User, as: 'Users' do
  actions :all, except: [:new, :destroy, :edit]
  config.filters = false

  controller do
    def permitted_params
      params.permit!
    end
    def scoped_collection
      super.where(locale: I18n.locale)
    end
  end

  index do
    selectable_column
    column :full_name do |user|
      link_to(user.full_name, admin_user_path(user))
    end
    column :email do |user|
      link_to(user.email, admin_user_path(user))
    end
    column :institution do |user|
      link_to(user.institution, admin_user_path(user))
    end
    column :invite_code do |user|
      link_to(user.invite_code, admin_user_path(user))
    end
    column :progress do |user|
      link_to("#{user.progress}%", admin_user_path(user))
    end
    column :final_assessment_status do |user|
      link_to(user.final_assessment_status, admin_user_path(user))
    end
    actions
  end

  form do |f|
    f.inputs 'Details' do
      f.input :email
      f.input :created_at, disabled: true, as: :date_select
    end
    f.actions
  end

  show title: :full_name do |user|
    attributes_table do
      row :full_name
      row :email
      row :institution
      row(:progress) {|model| "#{model.progress}%" }
      # row(:completed) { |model| model.completed? ? status_tag( 'yes', :ok )  : status_tag( 'no', :ok ) }
      # row(:passed) { |model| model.passed? ? status_tag( 'yes', :ok )  : status_tag( 'no', :ok ) }
      row :final_assessment_status
      row :invite_code
      row('Overall Marketing') { |model| model.marketing_overall_opt_in? ? status_tag( 'yes', :ok )  : status_tag( 'no', :ok ) }
      row('Email Marketing') { |model| model.marketing_email_opt_in? ? status_tag( 'yes', :ok )  : status_tag( 'no', :ok ) }
      row('Post Marketing') { |model| model.marketing_post_opt_in? ? status_tag( 'yes', :ok )  : status_tag( 'no', :ok ) }
      row('Representative Marketing') { |model| model.marketing_representative_opt_in? ? status_tag( 'yes', :ok )  : status_tag( 'no', :ok ) }
    end
  end
end
