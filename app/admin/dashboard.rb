ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc{ I18n.t('active_admin.dashboard') }

  # content title: proc{ I18n.t("active_admin.dashboard") } do
  #   columns do
  #     column do
  #       panel 'Recent Syllabuses' do
  #         table_for Syllabus.last(5).reverse.map do |t|
  #           t.column("Title") { |syllabus| link_to(syllabus.title, admin_syllabus_path(syllabus)) }
  #           t.column("Videos") { |syllabus| link_to(pluralize(syllabus.videos.count, 'video'), admin_syllabus_videos_path(syllabus)) }
  #         end
  #       end
  #     end
  #   end
  # end
end
