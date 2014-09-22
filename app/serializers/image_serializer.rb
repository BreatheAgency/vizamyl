class ImageSerializer < PageSerializer
  attributes :hello

  def hello
    'Hello Image'
  end
end
