ActiveAdmin.register QuestionIntro, namespace: :content do
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
    column :page_id do |video|
      link_to(video.page_id, content_chapter_video_path(chapter, video))
    end
    column :title do |video|
      link_to(video.title, content_chapter_video_path(chapter, video))
    end
    actions
  end

  form do |f|
    f.inputs do
      f.input :title, as: :html_editor
      f.input :body, as: :html_editor
      f.input :subject_area
    end
    f.actions
  end

  show title: :page_id do
    attributes_table do
      row :title
      row :body
      row :subject_area
    end
  end
end
