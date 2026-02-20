class TextSerializer < PageSerializer
  attributes :body, :abbreviations

  def controller_name
    'text_page'
  end

  def template_name
    'text_page'
  end
end
