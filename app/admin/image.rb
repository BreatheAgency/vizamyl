ActiveAdmin.register Image do
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
    f.translated_inputs 'Translated fields', switch_locale: true do |t|
      t.input :title
      t.input :source
    end
    f.actions
  end

  show title: :page_id do
    attributes_table do
      row :title
      row :source do |image|
        image_tag('//djqy74tsvke0j.cloudfront.net/images/' + image.source + '.png')
      end
    end
  end
end
