class VideoSerializer < PageSerializer
  attributes :hello

  def hello
    'Hello Video'
  end

  def controller_name
    'video_page'
  end

  def template_name
    'video_page'
  end
end
