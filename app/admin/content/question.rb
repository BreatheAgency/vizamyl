ActiveAdmin.register Question, namespace: :content do
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
      link_to(question.id, content_question_round_question_path(question_round, question))
    end
    column :title do |question|
      link_to(question.title, content_question_round_question_path(question_round, question))
    end
    column(:test_case) { |model| model['test_case'] ? status_tag( 'yes', :ok )  : status_tag( 'no', :ok ) }
    column :answers_count do |question|
      question.answers.count
    end
    actions
  end

  form do |f|
    f.inputs do
      f.input :title, as: :html_editor
      f.input :correct_title
      f.input :incorrect_title
      f.input :explanation_source
      f.input :test_case
    end
    f.has_many :interactive_sources, allow_destroy: true do |ff|
      ff.inputs do
        ff.input :label
        ff.input :source
        ff.input :height
      end
    end
    f.has_many :image_sources, allow_destroy: true do |ff|
      ff.inputs do
        ff.input :source
      end
    end
    f.has_many :answers, allow_destroy: true do |ff|
      ff.inputs do
        ff.input :body, as: :html_editor
        ff.input :correct
      end
    end
    f.actions
  end

  show do |question|
    attributes_table do
      row :title
      row :correct_title
      row :incorrect_title
      row :explanation_source
      row :explanation do |question|
        video_tag([
          "//#{Rails.application.secrets.content_host}/videos/#{question.explanation_source}/playlist.m3u8",
          "//#{Rails.application.secrets.content_host}/videos/#{question.explanation_source}/web.mp4",
          "//#{Rails.application.secrets.content_host}/videos/#{question.explanation_source}/web.webm"
          ], controls: true, autobuffer: true, size: '550x413')
        end
      row(:test_case) { |model| model['test_case'] ? status_tag( 'yes', :ok )  : status_tag( 'no', :ok ) }
    end
    panel 'Interactive Sources' do
      question.interactive_sources.each do |interactive_source|
        attributes_table_for interactive_source do
          row :id do |interactive_source|
            link_to(interactive_source.id, content_interactive_source_path(interactive_source))
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
            link_to(image_source.id, content_image_source_path(image_source))
          end
          row :source
        end
      end
    end
    panel 'Answers' do
      question.answers.each do |answer|
        attributes_table_for answer do
          row :id do |answer|
            link_to(answer.id, content_question_answer_path(question, answer))
          end
          row :body
          row(:correct) { |model| model['correct'] ? status_tag( 'yes', :ok )  : status_tag( 'no', :ok ) }
        end
      end
    end
  end
end
