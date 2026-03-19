require 'public_suffix'

class LoginLink
  class << self
    def col(base_url = nil)
      domain   = extract_domain(base_url)
      protocol = base_url&.start_with?('https') ? 'https' : 'http'

      {
        'au' => { country: 'Australia',       url: "#{protocol}://si.#{domain}",  locale: 'en-us', origin: 'au' },
        'at' => { country: 'Austria',         url: "#{protocol}://at.#{domain}",  locale: 'de-at', origin: 'at' },
        'be' => { country: 'Belgium',         url: "#{protocol}://ch.#{domain}",  locale: 'be',    origin: 'be' },
        'bg' => { country: 'Bulgaria',        url: "#{protocol}://ch.#{domain}",  locale: 'bg',    origin: 'bg' },
        'hr' => { country: 'Croatia',         url: "#{protocol}://ch.#{domain}",  locale: 'hr',    origin: 'hr' },
        'cz' => { country: 'Czechia',         url: "#{protocol}://ch.#{domain}",  locale: 'cz',    origin: 'cz' },
        'dk' => { country: 'Denmark',         url: "#{protocol}://ch.#{domain}",  locale: 'en-gb', origin: 'dk' },
        'ee' => { country: 'Estonia',         url: "#{protocol}://ch.#{domain}",  locale: 'en-gb', origin: 'ee' },
        'fi' => { country: 'Finland',         url: "#{protocol}://ch.#{domain}",  locale: 'en-gb', origin: 'fi' },
        # 'fr' => { country: 'France',        url: "#{protocol}://#{domain}",     locale: 'fr',    origin: 'fr' },
        'de' => { country: 'Germany',         url: "#{protocol}://de.#{domain}",  locale: 'de',    origin: 'de' },
        'gr' => { country: 'Greece',          url: "#{protocol}://ch.#{domain}",  locale: 'en-gb', origin: 'gr' },
        'hk' => { country: 'Hong Kong',       url: "#{protocol}://si.#{domain}",  locale: 'en-us', origin: 'hk' },
        'hu' => { country: 'Hungary',         url: "#{protocol}://ch.#{domain}",  locale: 'hu',    origin: 'hu' },
        'il' => { country: 'Israel',          url: "#{protocol}://si.#{domain}",  locale: 'en-us', origin: 'il' },
        'it' => { country: 'Italy',           url: "#{protocol}://it.#{domain}",  locale: 'it',    origin: 'it' },
        'jp' => { country: 'Japan',           url: "#{protocol}://jp.#{domain}",  locale: 'jp',    origin: 'jp' },
        'lu' => { country: 'Luxembourg',      url: "#{protocol}://ch.#{domain}",  locale: 'be',    origin: 'lu' },
        'nl' => { country: 'Netherlands',     url: "#{protocol}://ch.#{domain}",  locale: 'en-gb', origin: 'nl' },
        'no' => { country: 'Norway',          url: "#{protocol}://ch.#{domain}",  locale: 'en-gb', origin: 'no' },
        'pl' => { country: 'Poland',          url: "#{protocol}://ch.#{domain}",  locale: 'en-gb', origin: 'pl' },
        'sg' => { country: 'Singapore',       url: "#{protocol}://si.#{domain}",  locale: 'en-us', origin: 'sg' },
        'sk' => { country: 'Slovakia',        url: "#{protocol}://ch.#{domain}",  locale: 'sk',    origin: 'sk' },
        'si' => { country: 'Slovenia',        url: "#{protocol}://ch.#{domain}",  locale: 'si',    origin: 'si' },
        'kr' => { country: 'South Korea',     url: 'http://www.vizamyl.co.kr',    locale: 'kr',    origin: 'kr' },
        'es' => { country: 'Spain',           url: "#{protocol}://es.#{domain}",  locale: 'es',    origin: 'es' },
        'se' => { country: 'Sweden',          url: "#{protocol}://ch.#{domain}",  locale: 'en-gb', origin: 'se' },
        'ch' => { country: 'Switzerland',     url: "#{protocol}://ch.#{domain}",  locale: 'ch',    origin: 'ch' },
        'tw' => { country: 'Taiwan',          url: "#{protocol}://si.#{domain}",  locale: 'en-us', origin: 'tw' },
        'tr' => { country: 'Turkey',          url: "#{protocol}://si.#{domain}",  locale: 'en-us', origin: 'tr' },
        'gb' => { country: 'United Kingdom',  url: "#{protocol}://uk.#{domain}",  locale: 'en-gb', origin: 'gb' },
        'us' => { country: 'United States',   url: "#{protocol}://us.#{domain}",  locale: 'en-us', origin: 'us' }
      }
    end

    def generate_links(base_url = nil)
      col(base_url).transform_values do |info|
        "#{info[:url]}?origin=#{info[:origin]}"
      end
    end

    private

    def extract_domain(base_url)
      return 'localhost:3000' if base_url.nil? || base_url.include?('localhost')

      host = base_url.gsub(%r{https?://}, '').split('/').first

      parsed = PublicSuffix.parse(host)
      # parsed.domain gives you the root regardless of ccTLD
      parsed.domain
    rescue PublicSuffix::Error
      host
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
