class VideoSerializer < PageSerializer
  attributes :source, :mandatory

  def controller_name
    'video_page'
  end

  def template_name
    'video_page'
  end
end
