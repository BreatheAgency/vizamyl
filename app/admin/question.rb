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
    f.translated_inputs do |t|
      t.input :title, as: :html_editor
      t.input :explanation_source
    end
    f.has_many :interactive_sources, allow_destroy: true do |ff|
      ff.translated_inputs do |tt|
        tt.input :label
      end
      ff.inputs do
        ff.input :source
        ff.input :height
      end
    end
    f.has_many :image_sources, allow_destroy: true do |ff|
      ff.translated_inputs do |tt|
        tt.input :source
      end
    end
    f.has_many :answers, allow_destroy: true do |ff|
      ff.translated_inputs do |tt|
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
      row :explanation_source
    end
    panel 'Interactive Sources' do
      question.interactive_sources.each do |interactive_source|
        attributes_table_for interactive_source do
          row :id do |interactive_source|
            link_to(interactive_source.id, admin_interactive_source_path(interactive_source))
          end
          row :label
          row :source
          row :height
        end
      end
    end
    panel 'Image Sources' do
      question.image_sources.each do |image_source|
        attributes_table_for image_source do
          row :id do |image_source|
            link_to(image_source.id, admin_image_source_path(image_source))
          end
          row :source
        end
      end
    end
    panel 'Answers' do
      question.answers.each do |answer|
        attributes_table_for answer do
          row :id do |answer|
            link_to(answer.id, admin_question_answer_path(question, answer))
          end
          row :body
          row(:correct) { |model| model['correct'] ? status_tag( 'yes', :ok )  : status_tag( 'no', :ok ) }
        end
      end
    end
  end
end
