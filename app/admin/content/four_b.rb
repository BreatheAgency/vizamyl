ActiveAdmin.register FourB, namespace: :content do
  config.sort_order = 'id_asc'
  actions :all, except: [:new, :destroy]
  config.paginate = false
  config.filters = false

  belongs_to :chapter, polymorphic: true  

  controller do
    def permitted_params
      params.permit!
    end
  end

  index do
    column :page_id do |test|
      link_to(test.page_id, content_chapter_test_path(chapter, test))
    end
    column :title do |test|
      link_to(test.title, content_chapter_test_path(chapter, test))
    end
    # translation_status_flags
    actions
  end

  form do |f|
    f.inputs do
      f.input :title, as: :html_editor
      f.input :subject_area
    end
    f.has_many :question_rounds, allow_destroy: true do |ff|
      ff.inputs
    end
    f.actions
  end

  show title: :page_id do |test|
    attributes_table do
      row :title
      row :subject_area
    end
    panel 'Rounds' do
      test.question_rounds.each do |question_round|
        attributes_table_for question_round do
          row :id do |question_round|
            link_to(question_round.id, content_question_round_path(question_round))
          end
          row :questions_count do |question_round|
            question_round.questions.count
          end
        end
      end
    end
  end
end
