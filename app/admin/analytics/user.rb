ActiveAdmin.register User, as: 'Users' do
  actions :all, except: [:new]
  filter :locale, as: :select, label: 'Language', collection: [
    ['American', 'en-us'],
    ['Austrian', 'de-at'],
    ['English', 'en-gb'],
    ['French', 'fr'],
    ['German', 'de'],
    ['International English', 'en'],
    ['Italian', 'it'],
    ['Japanese', 'jp'],
    ['Spanish', 'es'],
  ]
  filter :origin, as: :select, label: 'Country', collection: [
    ['Australia', 'au'],
    ['Austria', 'at'],
    ['Belgium', 'be'],
    ['Croatia', 'hr'],
    ['Czech Republic', 'cz'],
    ['Denmark', 'dk'],
    ['Estonia', 'ee'],
    ['Finland', 'fi'],
    ['France', 'fr'],
    ['Germany', 'de'],
    ['Greece', 'gr'],
    ['Hong Kong', 'hk'],
    ['Hungary', 'hu'],
    ['International', 'en'],
    ['Italy', 'it'],
    ['Japan', 'jp'],
    ['Netherlands', 'nl'],
    ['Norway', 'no'],
    ['Singapore', 'sg'],
    ['Slovakia', 'sk'],
    ['Slovenia', 'si'],
    ['South Korea', 'kr'],
    ['Spain', 'es'],
    ['Sweden', 'se'],
    ['Switzerland', 'ch'],
    ['United Kingdom', 'gb'],
    ['United States', 'us'],
  ]
  filter :first_name, as: :string
  filter :last_name, as: :string
  filter :email, as: :string
  filter :institution, as: :string

  controller do
    def permitted_params
      params.permit!
    end
  end

  index do
    panel "Download options" do
      link_to "Export to Excel", admin_users_path(format: :csv)
    end
    selectable_column
    column 'Language' do |user|
      link_to(user.locale, admin_user_path(user))
    end
    column 'Country' do |user|
      link_to(user.origin, admin_user_path(user))
    end
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
      if user.invite_code.nil?
        link_to('Empty', admin_user_path(user))
      else
        link_to(user.invite_code, admin_user_path(user))
      end
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
      f.input :salutation
      f.input :first_name
      f.input :last_name
      f.input :institution, as: :string
      f.input :department if f.object.origin == 'jp'
      f.input :invite_code
      f.input :created_at, disabled: true, as: :date_select
    end
    f.actions
  end

  show title: :full_name do |user|
    attributes_table do
      row ('Language') { |model| model.locale }
      row ('Country') { |model| model.origin }
      row :full_name
      row :email
      row :institution
      row :department if user.origin == 'jp'
      row :city_or_state if user.origin == 'us'
      row :primary_specialty if user.origin == 'us'
      row(:progress) { |model| "#{model.progress}%" }
      row :final_assessment_status
      row :invite_code
      row('Overall Marketing') { |model| model.marketing_overall_opt_in? ? status_tag('yes') : status_tag('no') }
      row('Email Marketing') { |model| model.marketing_email_opt_in? ? status_tag('yes') : status_tag('no') }
      row('Post Marketing') { |model| model.marketing_post_opt_in? ? status_tag('yes') : status_tag('no') }
      row('Representative Marketing') { |model| model.marketing_representative_opt_in? ? status_tag('yes') : status_tag('no') }
      row :created_at
      row :last_sign_in_at
      row 'Course Completion Certificate' do
        link_to 'Course Completion Certificate', users_course_complete_path(locale: user.locale, user_id: user.id, from_active_admin: true, format: :pdf)
      end
    end
  end

  csv do
    column :created_at
    column('Language') { |model| model.locale }
    column('Country') { |model| model.origin }
    column :salutation
    column :first_name
    column :last_name
    column :email
    column :institution
    column :department
    column :city_or_state
    column :primary_specialty
    column :invite_code
    column :passed
    column :progress
    column :marketing_overall_opt_in
    column :marketing_email_opt_in
    column :marketing_post_opt_in
    column :marketing_representative_opt_in
  end
end
