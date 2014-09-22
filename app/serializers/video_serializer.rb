class VideoSerializer < PageSerializer
  attributes :hello

  def hello
    'Hello Video'
  end
end
