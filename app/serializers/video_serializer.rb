class VideoSerializer < PageSerializer
  attributes :body, :source, :abbreviations, :mandatory

  def controller_name
    'video_page'
  end

  def template_name
    'video_page'
  end
end
