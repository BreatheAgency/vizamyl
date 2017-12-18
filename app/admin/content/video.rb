ActiveAdmin.register Video, namespace: :content do
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
    column :page_id do |video|
      link_to(video.page_id, content_chapter_video_path(chapter, video))
    end
    column :title do |video|
      link_to(video.title, content_chapter_video_path(chapter, video))
    end
    column(:mandatory) { |model| model['mandatory'] ? status_tag('yes', :ok)  : status_tag('no',:ok) }
    actions
  end

  form do |f|
    f.inputs do
      f.input :title, as: :html_editor
      f.input :body, as: :html_editor
      f.input :subject_area
      f.input :source
      f.input :abbreviations, as: :html_editor
      f.input :mandatory
    end
    f.actions
  end

  show title: :page_id do
    attributes_table do
      row :title
      row :body
      row :subject_area
      row(:mandatory) { |model| model['mandatory'] ? status_tag('yes',:ok)  : status_tag('no',:ok) }
      row :source do |video|
        video_tag([
          "//#{Rails.application.secrets.content_host}/videos/#{video.source}/playlist.m3u8",
          "//#{Rails.application.secrets.content_host}/videos/#{video.source}/web.mp4",
          "//#{Rails.application.secrets.content_host}/videos/#{video.source}/web.webm"
        ], controls: true, autobuffer: true, size: '550x413')
      end
      row :abbreviations
    end
  end
end
