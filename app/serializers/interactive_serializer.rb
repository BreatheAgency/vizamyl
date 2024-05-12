class InteractiveSerializer < PageSerializer
  attributes :body, :interactive_source_ids
  has_many :interactive_sources

  def controller_name
    'interactive_page'
  end

  def template_name
    'interactive_page'
  end

  def interactive_source_ids
    object.interactive_sources.ids
  end
end
