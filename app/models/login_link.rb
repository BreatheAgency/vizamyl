class LoginLink
  class << self
    def col
      base_url = Rails.application.config.vizamyl_base_url
      {
        'au' => { country: 'Australia', url: "https://si.readvizamyl.com", locale: 'en-us', origin: 'au' },
        'at' => { country: 'Austria', url: "https://at.readvizamyl.com", locale: 'de-at', origin: 'at' },
        'be' => { country: 'Belgium', url: "https://ch.readvizamyl.com", locale: 'be', origin: 'be' },
        'bg' => { country: 'Bulgaria', url: "https://ch.readvizamyl.com", locale: 'bg', origin: 'bg' },
        'hr' => { country: 'Croatia', url: "https://ch.readvizamyl.com", locale: 'hr', origin: 'hr' },
        'cz' => { country: 'Czechia', url: "https://ch.readvizamyl.com", locale: 'cz', origin: 'cz' },
        'dk' => { country: 'Denmark', url: "https://ch.readvizamyl.com", locale: 'en-gb', origin: 'dk' },
        'ee' => { country: 'Estonia', url: "https://ch.readvizamyl.com", locale: 'en-gb', origin: 'ee' },
        'fi' => { country: 'Finland', url: "https://ch.readvizamyl.com", locale: 'en-gb', origin: 'fi' },
        'fr' => { country: 'France', url: "#{base_url}", locale: 'fr', origin: 'fr' },
        'de' => { country: 'Germany', url: "https://de.readvizamyl.com", locale: 'de', origin: 'de' },
        'gr' => { country: 'Greece', url: "https://ch.readvizamyl.com", locale: 'en-gb', origin: 'gr' },
        'hk' => { country: 'Hong Kong', url: "https://si.readvizamyl.com", locale: 'en-us', origin: 'hk' },
        'hu' => { country: 'Hungary', url: "https://ch.readvizamyl.com", locale: 'hu', origin: 'hu' },
        'il' => { country: 'Israel', url: "https://si.readvizamyl.com", locale: 'en-us', origin: 'il' },
        'it' => { country: 'Italy', url: "https://it.readvizamyl.com", locale: 'it', origin: 'it' },
        'jp' => { country: 'Japan', url: "https://jp.readvizamyl.com", locale: 'jp', origin: 'jp' },        
        'lu' => { country: 'Luxembourg', url: "https://ch.readvizamyl.com", locale: 'be', origin: 'lu' },
        'nl' => { country: 'Netherlands', url: "https://ch.readvizamyl.com", locale: 'en-gb', origin: 'nl' },
        'no' => { country: 'Norway', url: "https://ch.readvizamyl.com", locale: 'en-gb', origin: 'no' },
        'pl' => { country: 'Poland', url: "https://ch.readvizamyl.com", locale: 'en-gb', origin: 'pl' },
        'sg' => { country: 'Singapore', url: "https://si.readvizamyl.com", locale: 'en-us', origin: 'sg' },
        'sk' => { country: 'Slovakia', url: "https://ch.readvizamyl.com", locale: 'sk', origin: 'sk' },
        'si' => { country: 'Slovenia', url: "https://ch.readvizamyl.com", locale: 'si', origin: 'si' },        
        'kr' => { country: 'South Korea', url: 'http://www.vizamyl.co.kr', locale: 'kr', origin: 'kr' },
        'es' => { country: 'Spain', url: "https://es.readvizamyl.com", locale: 'es', origin: 'es' },
        'se' => { country: 'Sweden', url: "https://ch.readvizamyl.com", locale: 'en-gb', origin: 'se' },
        'ch' => { country: 'Switzerland', url: "https://ch.readvizamyl.com", locale: 'ch', origin: 'ch' },        
        'tw' => { country: 'Taiwan', url: "https://si.readvizamyl.com", locale: 'en-us', origin: 'tw' },
        'tr' => { country: 'Turkey', url: "https://si.readvizamyl.com", locale: 'en-us', origin: 'tr' },        
        'gb' => { country: 'United Kingdom', url: "https://uk.readvizamyl.com", locale: 'en-gb', origin: 'gb' },
        'us' => { country: 'United States', url: "https://us.readvizamyl.com", locale: 'en-us', origin: 'us' }
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