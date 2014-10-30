class VideoSerializer < PageSerializer
  attributes :body, :source, :references, :mandatory

  def controller_name
    'video_page'
  end

  def template_name
    'video_page'
  end
end
