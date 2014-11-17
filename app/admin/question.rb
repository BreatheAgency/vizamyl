ActiveAdmin.register Question do
  config.paginate = false
  config.filters = false
  # menu false

  belongs_to :question_round

  controller do
    def permitted_params
      params.permit!
    end
  end

  index do
    column :id do |question|
      link_to(question.id, admin_question_round_question_path(question_round, question))
    end
    column :title do |question|
      link_to(question.title, admin_question_round_question_path(question_round, question))
    end
    column :answers_count do |question|
      question.answers.count
    end
    # translation_status_flags
    actions
  end

  form do |f|
    f.translated_inputs switch_locale: true do |t|
      t.input :title, as: :html_editor
    end
    f.has_many :answers, allow_destroy: true do |ff|
      ff.translated_inputs switch_locale: true do |tt|
        tt.input :body, as: :html_editor
      end
      ff.inputs do
        ff.input :correct
      end
    end
    f.actions
  end

  show do |question|
    attributes_table do
      row :title
    end
    panel 'Answers' do
      question.answers.each do |answer|
        attributes_table_for answer do
          row :id do |answer|
            link_to(answer.id, admin_question_answers_path(question, answer))
          end
          row :body
          row(:correct) { |model| model['correct'] ? status_tag( 'yes', :ok )  : status_tag( 'no', :ok ) }
        end
      end
    end
  end
end
