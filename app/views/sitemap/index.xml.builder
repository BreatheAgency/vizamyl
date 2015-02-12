xml.instruct!
xml.url do
  xml.loc 'https://www.readvizamyl.com'
  xml.priority 1.0
end
I18n.available_locales.each do |locale|
  xml.url do
    xml.loc "https://www.readvizamyl.com/#{locale}"
    xml.priority 0.8
  end
end
