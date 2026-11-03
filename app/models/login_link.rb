class LoginLink
  class << self
    def col(base_url:)
      countries = {
        'au' => { country: 'Australia', locale: 'en-us', origin: 'au' },
        'at' => { country: 'Austria', locale: 'de-at', origin: 'at' },
        'be' => { country: 'Belgium', locale: 'be', origin: 'be' },
        'bg' => { country: 'Bulgaria', locale: 'bg', origin: 'bg' },
        'hr' => { country: 'Croatia', locale: 'hr', origin: 'hr' },
        'cz' => { country: 'Czechia', locale: 'cz', origin: 'cz' },
        'dk' => { country: 'Denmark', locale: 'en-gb', origin: 'dk' },
        'ee' => { country: 'Estonia', locale: 'en-gb', origin: 'ee' },
        'fi' => { country: 'Finland', locale: 'en-gb', origin: 'fi' },
        'fr' => { country: 'France', locale: 'fr', origin: 'fr' },
        'de' => { country: 'Germany', locale: 'de', origin: 'de' },
        'gr' => { country: 'Greece', locale: 'en-gb', origin: 'gr' },
        'hk' => { country: 'Hong Kong', locale: 'en-us', origin: 'hk' },
        'hu' => { country: 'Hungary', locale: 'hu', origin: 'hu' },
        'il' => { country: 'Israel', locale: 'en-us', origin: 'il' },
        'it' => { country: 'Italy', locale: 'it', origin: 'it' },
        'jp' => { country: 'Japan', locale: 'jp', origin: 'jp' },
        'lu' => { country: 'Luxembourg', locale: 'be', origin: 'lu' },
        'nl' => { country: 'Netherlands', locale: 'en-gb', origin: 'nl' },
        'no' => { country: 'Norway', locale: 'en-gb', origin: 'no' },
        'pl' => { country: 'Poland', locale: 'en-gb', origin: 'pl' },
        'sg' => { country: 'Singapore', locale: 'en-us', origin: 'sg' },
        'sk' => { country: 'Slovakia', locale: 'sk', origin: 'sk' },
        'si' => { country: 'Slovenia', locale: 'si', origin: 'si' },
        'kr' => { country: 'South Korea', locale: 'kr', origin: 'kr' },
        'es' => { country: 'Spain', locale: 'es', origin: 'es' },
        'se' => { country: 'Sweden', locale: 'en-gb', origin: 'se' },
        'ch' => { country: 'Switzerland', locale: 'ch', origin: 'ch' },
        'tw' => { country: 'Taiwan', locale: 'en-us', origin: 'tw' },
        'tr' => { country: 'Turkey', locale: 'en-us', origin: 'tr' },
        'gb' => { country: 'United Kingdom', locale: 'en-gb', origin: 'gb' },
        'us' => { country: 'United States', locale: 'en-us', origin: 'us' }
      }

      countries.transform_values do |info|
        info.merge(url: base_url)
      end
    end

    def generate_links(base_url:)
      col(base_url: base_url).transform_values do |info|
        "#{info[:url]}?origin=#{info[:origin]}"
      end
    end
  end
end