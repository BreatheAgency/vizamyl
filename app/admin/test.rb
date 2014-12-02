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
    column :failure_step do |test|
      if test.failure_step.present?
        link_to(test.failure_step.page.page_id, polymorphic_url([:admin, test.failure_step.page.chapter, test.failure_step.page]))
      end
    end
    # translation_status_flags
    actions
  end

  form do |f|
    f.translated_inputs switch_locale: true do |t|
      t.input :title, as: :html_editor
      t.input :subject_area
    end
    f.has_many :question_rounds, allow_destroy: true do |ff|
      ff.inputs
    end
    f.inputs do
      f.input :failure_step, as: :select, collection: Step.includes(:page).all.map{|step| [step.page.page_id, step.id]}.sort_by { |step| step[0] }
      # f.input :failure_step, as: :select, collection: Step.select(:id).uniq
    end
    f.actions
  end

  show title: :page_id do |test|
    attributes_table do
      row :title
      row :subject_area
      row :failure_step do |test|
        if test.failure_step.present?
          link_to(test.failure_step.page.page_id, polymorphic_url([:admin, test.failure_step.page.chapter, test.failure_step.page]))
        end
      end
    end
    panel 'Rounds' do
      test.question_rounds.each do |question_round|
        attributes_table_for question_round do
          row :id do |question_round|
            link_to(question_round.id, admin_question_round_path(question_round))
          end
          row :questions_count do |question_round|
            question_round.questions.count
          end
        end
      end
    end
  end
end
