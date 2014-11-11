ActiveAdmin.register QuestionSet do
  config.paginate = false
  config.filters = false
  menu false

  # belongs_to :subject, polymorphic: true

  controller do
    def permitted_params
      params.permit!
    end
  end

  index do
    column :id do |question_set|
      link_to(question_set.id, admin_question_sets_path(question_set))
    end
    column :title do |question_set|
      link_to(question_set.title, admin_question_sets_path(question_set))
    end
    column :questions_count do |question_set|
      question_set.questions.count
    end
    # translation_status_flags
    actions
  end

  form do |f|
    f.translated_inputs switch_locale: true do |t|
      t.input :title, as: :html_editor
    end
    f.has_many :questions, allow_destroy: true do |ff|
      ff.translated_inputs switch_locale: true do |tt|
        tt.input :body, as: :html_editor
      end
      ff.inputs do
        ff.input :correct
      end
    end
    f.actions
  end

  show do |question_set|
    attributes_table do
      row :title
    end
    panel 'Questions' do
      question_set.questions.each do |question|
        attributes_table_for question do
          row :id do |question|
            link_to(question.id, admin_question_set_question_path(question_set, question))
          end
          row :body
          row(:correct) { |model| model['correct'] ? status_tag( 'yes', :ok )  : status_tag( 'no', :ok ) }
        end
      end
    end
  end
end
