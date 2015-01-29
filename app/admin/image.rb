ActiveAdmin.register Image do
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
    column :page_id do |video|
      link_to(video.page_id, admin_chapter_video_path(chapter, video))
    end
    column :title do |video|
      link_to(video.title, admin_chapter_video_path(chapter, video))
    end
    # translation_status_flags
    actions
  end

  form do |f|
    f.translated_inputs do |t|
      t.input :title
      t.input :subject_area
      t.input :source
    end
    f.actions
  end

  show title: :page_id do
    attributes_table do
      row :title
      row :subject_area
      row :source do |image|
        image_tag('//dki1hrtf104z9.cloudfront.net/images/' + image.source + '.jpg')
      end
    end
  end
end
