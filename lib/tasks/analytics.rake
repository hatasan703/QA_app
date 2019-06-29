require 'google/apis/analyticsreporting_v4'
require 'google/api_client/auth/key_utils'

namespace :analytics do
  desc 'get popular posts from google analytics'

  task popular_posts: :environment do
    keyfile = Rails.root.join('google_analytics.p12')
    analytics = Google::Apis::AnalyticsreportingV4
    client = analytics::AnalyticsReportingService.new
    client.authorization = Signet::OAuth2::Client.new(
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      audience: 'https://accounts.google.com/o/oauth2/token',
      scope: 'https://www.googleapis.com/auth/analytics.readonly',
      issuer: ENV['GA_ISSUER'],
      signing_key: Google::APIClient::KeyUtils.load_from_pkcs12(keyfile, ENV['GA_KEY_SECRET'])
    )
    client.authorization.fetch_access_token!
  end
end
