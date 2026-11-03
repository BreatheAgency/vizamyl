config = Rails.application.config_for(:secrets)
Rails.application.config.x.vizamyl = config

codes = config.respond_to?(:invite_codes) ? config.invite_codes : nil
warn "[vizamyl config check] env=#{Rails.env} keys=#{config.respond_to?(:keys) ? config.keys.inspect : config.class} invite_codes=#{codes.class if codes} count=#{codes.size if codes.respond_to?(:size)}"