class LoginLink
  class << self
    def col
      {
        'au' => { country: 'Australia', url: 'https://stg-www.readvizamyl.com', locale: 'en-us', origin: 'au' },
        'at' => { country: 'Austria', url: 'https://stg-www.readvizamyl.com', locale: 'de-at', origin: 'at' },
        'be' => { country: 'Belgium', url: 'https://stg-www.readvizamyl.com', locale: 'be', origin: 'be' },
        'hr' => { country: 'Croatia', url: 'https://stg-www.readvizamyl.com', locale: 'en-gb', origin: 'hr' },
        'cz' => { country: 'Czech Republic', url: 'https://stg-www.readvizamyl.com', locale: 'en-gb', origin: 'cz' },
        'dk' => { country: 'Denmark', url: 'https://stg-www.readvizamyl.com', locale: 'en-gb', origin: 'dk' },
        'ee' => { country: 'Estonia', url: 'https://stg-www.readvizamyl.com', locale: 'en-gb', origin: 'ee' },
        'fi' => { country: 'Finland', url: 'https://stg-www.readvizamyl.com', locale: 'en-gb', origin: 'fi' },
        'fr' => { country: 'France', url: 'https://stg-www.readvizamyl.com', locale: 'fr', origin: 'fr' },
        'de' => { country: 'Germany', url: 'https://stg-www.readvizamyl.com', locale: 'de', origin: 'de' },
        'gr' => { country: 'Greece', url: 'https://stg-www.readvizamyl.com', locale: 'en-gb', origin: 'gr' },
        'hk' => { country: 'Hong Kong', url: 'https://stg-www.readvizamyl.com', locale: 'en-us', origin: 'hk' },
        'hu' => { country: 'Hungary', url: 'https://stg-www.readvizamyl.com', locale: 'en-gb', origin: 'hu' },
        'en' => { country: 'International', url: 'https://stg-www.readvizamyl.com', locale: 'en', origin: 'en' },
        'it' => { country: 'Italy', url: 'https://stg-www.readvizamyl.com', locale: 'it', origin: 'it' },
        'jp' => { country: 'Japan', url: 'https://stg-www.readvizamyl.com', locale: 'jp', origin: 'jp' },
        'nl' => { country: 'Netherlands', url: 'https://stg-www.readvizamyl.com', locale: 'en-gb', origin: 'nl' },
        'no' => { country: 'Norway', url: 'https://stg-www.readvizamyl.com', locale: 'en-gb', origin: 'no' },
        'sg' => { country: 'Singapore', url: 'https://stg-www.readvizamyl.com', locale: 'en-us', origin: 'sg' },
        'sk' => { country: 'Slovakia', url: 'https://stg-www.readvizamyl.com', locale: 'en-gb', origin: 'sk' },
        'si' => { country: 'Slovenia', url: 'https://stg-www.readvizamyl.com', locale: 'si', origin: 'si' },
        'kr' => { country: 'South Korea', url: 'http://www.vizamyl.co.kr', locale: 'kr', origin: 'kr' },
        'es' => { country: 'Spain', url: 'https://stg-www.readvizamyl.com', locale: 'es', origin: 'es' },
        'se' => { country: 'Sweden', url: 'https://stg-www.readvizamyl.com', locale: 'en-gb', origin: 'se' },
        'ch' => { country: 'Switzerland', url: 'https://stg-www.readvizamyl.com', locale: 'ch', origin: 'ch' },
        'gb' => { country: 'United Kingdom', url: 'https://stg-www.readvizamyl.com', locale: 'en-gb', origin: 'gb' },
        'us' => { country: 'United States', url: 'https://stg-www.readvizamyl.com', locale: 'en-us', origin: 'us' }
      }
    end

    def generate_links
      col.transform_values do |info|
        "#{info[:url]}?origin=#{info[:origin]}"
      end
    end
  end
end


# class LoginLink
#   class << self
#     def col_1
#       {
#        'en-us': 'United States',
#        'en-gb': 'United Kingdom',
#        'de-at': 'Austria',
#        'be': 'Belgium / Luxembourg',
#       }
#     end

#     def col_2
#       {
#        'fr': 'France',
#        'de': 'Germany',
#        'it': 'Italy',
#        'jp': 'Japan',
#       }
#     end

#     def col_3
#       {
#        'si': 'Slovenia',
#        'es': 'Spain',
#        'http://www.vizamyl.co.kr': 'South Korea',
#        'ch': 'Switzerland'
#       }
#     end
#   end
# end
