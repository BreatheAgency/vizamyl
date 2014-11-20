class InteractiveSerializer < PageSerializer
  attributes :body
  has_many :interactive_sources

  def controller_name
    'interactive_page'
  end

  def template_name
    'interactive_page'
  end
end
