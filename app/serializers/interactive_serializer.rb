class InteractiveSerializer < PageSerializer
  attributes :body, :interactive_ids
  has_many :interactive_sources

  def controller_name
    'interactive_page'
  end

  def template_name
    'interactive_page'
  end

  def interactive_ids
    object.interactive_sources.ids
  end
end
