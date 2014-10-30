class TextSerializer < PageSerializer
  attributes :body

  def controller_name
    'text_page'
  end

  def template_name
    'text_page'
  end
end
