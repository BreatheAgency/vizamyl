class LoginLink
  class << self

    # Determine root domain from the actual request host
    def extract_root_domain(host)
      return "langselector.com" if host.include?("langselector.com")
      return "readvizamyl.com" if host.include?("readvizamyl.com")

      raise ArgumentError, "Unknown host: #{host}"
    end

    def build_url(subdomain, root_domain)
      "https://#{subdomain}.#{root_domain}"
    end

    def col
      {
        'au' => { country: 'Australia',        sub: 'si', locale: 'en-us', origin: 'au' },
        'at' => { country: 'Austria',          sub: 'at', locale: 'de-at', origin: 'at' },
        'be' => { country: 'Belgium',          sub: 'be', locale: 'be',    origin: 'be' },
        'bg' => { country: 'Bulgaria',         sub: 'bg', locale: 'bg',    origin: 'bg' },
        'hr' => { country: 'Croatia',          sub: 'hr', locale: 'en-gb', origin: 'hr' },
        'cz' => { country: 'Czechia',          sub: 'cz', locale: 'en-gb', origin: 'cz' },
        'dk' => { country: 'Denmark',          sub: 'dk', locale: 'en-gb', origin: 'dk' },
        'ee' => { country: 'Estonia',          sub: 'ee', locale: 'en-gb', origin: 'ee' },
        'fi' => { country: 'Finland',          sub: 'fi', locale: 'en-gb', origin: 'fi' },
        'fr' => { country: 'France',           sub: 'fr', locale: 'fr',    origin: 'fr' },
        'de' => { country: 'Germany',          sub: 'de', locale: 'de',    origin: 'de' },
        'gr' => { country: 'Greece',           sub: 'gr', locale: 'en-gb', origin: 'gr' },
        'hk' => { country: 'Hong Kong',        sub: 'si', locale: 'en-us', origin: 'hk' },
        'hu' => { country: 'Hungary',          sub: 'hu', locale: 'en-gb', origin: 'hu' },
        'il' => { country: 'Israel',           sub: 'si', locale: 'en-us', origin: 'il' },
        'it' => { country: 'Italy',            sub: 'it', locale: 'it',    origin: 'it' },
        'jp' => { country: 'Japan',            sub: 'jp', locale: 'jp',    origin: 'jp' },
        'lu' => { country: 'Luxembourg',       sub: 'be', locale: 'be',    origin: 'lu' },
        'nl' => { country: 'Netherlands',      sub: 'nl', locale: 'en-gb', origin: 'nl' },
        'no' => { country: 'Norway',           sub: 'no', locale: 'en-gb', origin: 'no' },
        'pl' => { country: 'Poland',           sub: 'pl', locale: 'en-gb', origin: 'pl' },
        'sg' => { country: 'Singapore',        sub: 'si', locale: 'en-us', origin: 'sg' },
        'sk' => { country: 'Slovakia',         sub: 'sk', locale: 'en-gb', origin: 'sk' },
        'si' => { country: 'Slovenia',         sub: 'si', locale: 'si',    origin: 'si' },
        'kr' => { country: 'South Korea',      external: 'http://www.vizamyl.co.kr', locale: 'kr', origin: 'kr' },
        'es' => { country: 'Spain',            sub: 'es', locale: 'es',    origin: 'es' },
        'se' => { country: 'Sweden',           sub: 'se', locale: 'en-gb', origin: 'se' },
        'ch' => { country: 'Switzerland',      sub: 'ch', locale: 'ch',    origin: 'ch' },
        'tw' => { country: 'Taiwan',           sub: 'si', locale: 'en-us', origin: 'tw' },
        'tr' => { country: 'Turkey',           sub: 'si', locale: 'en-us', origin: 'tr' },
        'gb' => { country: 'United Kingdom',   sub: 'gb', locale: 'en-gb', origin: 'gb' },
        'us' => { country: 'United States',    sub: 'us', locale: 'en-us', origin: 'us' }
      }
    end

    def generate_links(current_host)
      root_domain = extract_root_domain(current_host)

      col.transform_values do |info|
        if info[:external]
          "#{info[:external]}?origin=#{info[:origin]}"
        else
          "#{build_url(info[:sub], root_domain)}?origin=#{info[:origin]}"
        end
      end
    end
  end
end