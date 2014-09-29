class ImageSerializer < PageSerializer
  attributes :hello

  def hello
    'Hello Image'
  end

  def controller_name
    'image_page'
  end

  def template_name
    'image_page'
  end
end
