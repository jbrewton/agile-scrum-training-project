module BitbucketHelper
  include HTTParty
  base_uri 'https://bitbucket.org/api/2.0/'

  def setup(service, page)
    @options = { query: {site: service, page: page} }
    headers = { 
      "oauth_consumer_key" => Rails.application.secrets.omniauth_provider_key, 
      "oauth_token"=> "", 
      "oauth_nonce" => "",
      "oauth_signature" => "",
      "oauth_signature_method" => "",
      "oauth_timestamp" => "",
      "oauth_verifier" => ""
    }
  end

  def questions
    path = '/repositories/' + current_user.uid
    #self.class.get(path, @options)
  end
=begin
    GET /api/2.0/repositories/vetrik77/test HTTP/1.1
=end
end