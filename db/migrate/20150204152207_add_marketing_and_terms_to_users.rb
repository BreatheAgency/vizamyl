class AddMarketingAndTermsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :terms_and_conditions_opt_in, :boolean, default: false
    add_column :users, :marketing_overall_opt_in, :boolean, default: false
    add_column :users, :marketing_email_opt_in, :boolean, default: false
    add_column :users, :marketing_post_opt_in, :boolean, default: false
    add_column :users, :marketing_representative_opt_in, :boolean, default: false
  end
end
