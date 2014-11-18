SitemapGenerator::Sitemap.default_host = 'https://www.readvizamyl.com'
SitemapGenerator::Sitemap.create do
  I18n.available_locales.each do |locale|
    add "/#{locale}"
  end
end
