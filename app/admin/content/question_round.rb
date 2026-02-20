ActiveAdmin.register QuestionRound, namespace: :content do
  actions :all, except: [:new]
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
    column :id do |question_round|
      link_to(question_round.id, content_question_round_path(question_round))
    end
    column :subject do |question_round|
      link_to(question_round.subject.title, polymorphic_url([:content, question_round.subject.chapter, question_round.subject]))
    end
    column :questions_count do |question_round|
      question_round.questions.count
    end
    actions
  end

  form do |f|
    f.has_many :questions, allow_destroy: true do |ff|
      ff.inputs do
        ff.input :title, as: :html_editor
      end
    end
    f.actions
  end

  show do |question_round|
    panel 'Questions' do
      question_round.questions.each do |question|
        attributes_table_for question do
          row :id do |question|
            link_to(question.id, content_question_round_question_path(question_round, question))
          end
          row :title do |question|
            link_to(question.title, content_question_round_question_path(question_round, question))
          end
        end
      end
    end
  end
end
