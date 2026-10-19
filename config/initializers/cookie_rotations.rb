# Lets Rails still read cookies signed/encrypted with the old SHA1 settings,
# and rewrites them with the new defaults on the next request.
# Remove once old sessions have expired.
Rails.application.config.after_initialize do
  Rails.application.config.action_dispatch.cookies_rotations.tap do |cookies|
    salt = Rails.application.config.action_dispatch.authenticated_encrypted_cookie_salt
    cookies.rotate :encrypted, salt, digest: "SHA1"
    cookies.rotate :signed, digest: "SHA1"
  end
end