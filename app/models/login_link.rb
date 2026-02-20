class LoginLink
  class << self
    def col
      base_url = Rails.application.config.vizamyl_base_url
      {
        'au' => { country: 'Australia', url: "https://si.readvizamyl.com", locale: 'en-us', origin: 'au' },
        'at' => { country: 'Austria', url: "https://at.readvizamyl.com", locale: 'de-at', origin: 'at' },
        'be' => { country: 'Belgium', url: "#{base_url}", locale: 'be', origin: 'be' },
        'bg' => { country: 'Bulgaria', url: "#{base_url}", locale: 'bg', origin: 'bg' },
        'hr' => { country: 'Croatia', url: "#{base_url}", locale: 'en-gb', origin: 'hr' },
        'cz' => { country: 'Czechia', url: "#{base_url}", locale: 'en-gb', origin: 'cz' },
        'dk' => { country: 'Denmark', url: "#{base_url}", locale: 'en-gb', origin: 'dk' },
        'ee' => { country: 'Estonia', url: "#{base_url}", locale: 'en-gb', origin: 'ee' },
        'fi' => { country: 'Finland', url: "#{base_url}", locale: 'en-gb', origin: 'fi' },
        'fr' => { country: 'France', url: "#{base_url}", locale: 'fr', origin: 'fr' },
        'de' => { country: 'Germany', url: "https://de.readvizamyl.com", locale: 'de', origin: 'de' },
        'gr' => { country: 'Greece', url: "#{base_url}", locale: 'en-gb', origin: 'gr' },
        'hk' => { country: 'Hong Kong', url: "https://si.readvizamyl.com", locale: 'en-us', origin: 'hk' },
        'hu' => { country: 'Hungary', url: "#{base_url}", locale: 'en-gb', origin: 'hu' },
        'il' => { country: 'Israel', url: "https://si.readvizamyl.com", locale: 'en-us', origin: 'il' },
        'it' => { country: 'Italy', url: "https://it.readvizamyl.com", locale: 'it', origin: 'it' },
        'jp' => { country: 'Japan', url: "https://jp.readvizamyl.com", locale: 'jp', origin: 'jp' },        
        'lu' => { country: 'Luxembourg', url: "#{base_url}", locale: 'be', origin: 'lu' },
        'nl' => { country: 'Netherlands', url: "#{base_url}", locale: 'en-gb', origin: 'nl' },
        'no' => { country: 'Norway', url: "#{base_url}", locale: 'en-gb', origin: 'no' },
        'pl' => { country: 'Poland', url: "#{base_url}", locale: 'en-gb', origin: 'pl' },
        'sg' => { country: 'Singapore', url: "https://si.readvizamyl.com", locale: 'en-us', origin: 'sg' },
        'sk' => { country: 'Slovakia', url: "#{base_url}", locale: 'en-gb', origin: 'sk' },
        'si' => { country: 'Slovenia', url: "#{base_url}", locale: 'si', origin: 'si' },        
        'kr' => { country: 'South Korea', url: 'http://www.vizamyl.co.kr', locale: 'kr', origin: 'kr' },
        'es' => { country: 'Spain', url: "https://es.readvizamyl.com", locale: 'es', origin: 'es' },
        'se' => { country: 'Sweden', url: "#{base_url}", locale: 'en-gb', origin: 'se' },
        'ch' => { country: 'Switzerland', url: "#{base_url}", locale: 'ch', origin: 'ch' },        
        'tw' => { country: 'Taiwan', url: "https://si.readvizamyl.com", locale: 'en-us', origin: 'tw' },
        'tr' => { country: 'Turkey', url: "https://si.readvizamyl.com", locale: 'en-us', origin: 'tr' },        
        'gb' => { country: 'United Kingdom', url: "#{base_url}", locale: 'en-gb', origin: 'gb' },
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
