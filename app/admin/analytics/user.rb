ActiveAdmin.register User, as: 'Users' do
  actions :all, except: [:new, :destroy, :edit]
  filter :locale, as: :select, label: 'Language', collection: [
    ['English', 'en-gb'],
    ['American', 'en-us'],
    ['German', 'de'],
    ['Austrian', 'de-at'],
    ['Spanish', 'es'],
    ['French', 'fr'],
    ['Italian', 'it'],
    ['International English', 'en'],
    ['Japanese', 'jp'],
  ]
  filter :origin, as: :select, label: 'Country', collection: [
    ['International', 'en'],
    ['United Kingdom', 'gb'],
    ['United States', 'us'],
    ['Germany', 'de'],
    ['Austria', 'at'],
    ['Belgium', 'be'],
    ['Spain', 'es'],
    ['France', 'fr'],
    ['Italy', 'it'],
    ['Slovakia', 'sk'],
    ['Slovenia', 'si'],
    ['Czech Republic', 'cz'],
    ['Croatia', 'hr'],
    ['Hungary', 'hu'],
    ['Denmark', 'dk'],
    ['Finland', 'fi'],
    ['Norway', 'no'],
    ['Estonia', 'ee'],
    ['Netherlands', 'nl'],
    ['Sweden', 'se'],
    ['South Korea', 'kr'],
    ['Hong Kong', 'hk'],
    ['Singapore', 'sg'],
    ['Australia', 'au'],
    ['Japan', 'jp'],
  ]
  filter :institution, as: :string

  controller do
    def permitted_params
      params.permit!
    end
  end

  index do
    panel "Download options" do
      link_to "Export to Excel", params.merge(format: :csv)
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
    column :department do |user|
      if user.locale == 'jp'
        user.department
      else
        '<p class="na"><small>Japan only</small></p>'.html_safe
      end
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
      row :department
      row(:progress) { |model| "#{model.progress}%" }
      row :final_assessment_status
      row :invite_code
      row('Overall Marketing') { |model| model.marketing_overall_opt_in? ? status_tag( 'yes', :ok )  : status_tag( 'no', :ok ) }
      row('Email Marketing') { |model| model.marketing_email_opt_in? ? status_tag( 'yes', :ok )  : status_tag( 'no', :ok ) }
      row('Post Marketing') { |model| model.marketing_post_opt_in? ? status_tag( 'yes', :ok )  : status_tag( 'no', :ok ) }
      row('Representative Marketing') { |model| model.marketing_representative_opt_in? ? status_tag( 'yes', :ok )  : status_tag( 'no', :ok ) }
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
    column :invite_code
    column :passed
    column :progress
    column :marketing_overall_opt_in
    column :marketing_email_opt_in
    column :marketing_post_opt_in
    column :marketing_representative_opt_in
  end
end
