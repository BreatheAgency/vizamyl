ActiveAdmin.register Test do
  config.sort_order = 'id_asc'
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

  index do
    column :page_id do |test|
      link_to(test.page_id, admin_chapter_test_path(chapter, test))
    end
    column :title do |test|
      link_to(test.title, admin_chapter_test_path(chapter, test))
    end
    # translation_status_flags
    actions
  end

  form do |f|
    f.translated_inputs switch_locale: true do |t|
      t.input :title, as: :html_editor
      t.input :subject_area
    end
    f.has_many :question_sets, allow_destroy: true do |ff|
      ff.translated_inputs switch_locale: true do |tt|
        tt.input :title, as: :html_editor
      end
    end
    f.actions
  end

  show title: :page_id do |test|
    attributes_table do
      row :title
      row :subject_area
    end
    panel 'Question Sets' do
      test.question_sets.each do |question_set|
        attributes_table_for question_set do
          row :title do |question_set|
            link_to(question_set.title, admin_question_set_path(question_set))
          end
          row :questions_count do |question_set|
            question_set.questions.count
          end
        end
      end
    end
  end
end
