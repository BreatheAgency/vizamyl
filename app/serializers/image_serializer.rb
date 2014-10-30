class ImageSerializer < PageSerializer
  attributes :source

  def controller_name
    'image_page'
  end

  def template_name
    'image_page'
  end
end
