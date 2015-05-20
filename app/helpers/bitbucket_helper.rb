require 'oauth2'
module BitbucketHelper
  def headers
    base_uri = "https://bitbucket.org/api/2.0/"
    
    header = { 
      "oauth_consumer_key" => Rails.application.secrets.omniauth_provider_key, 
      "oauth_token"=> current_user.oauth_token, 
      "oauth_nonce" => nonce,
      "oauth_signature_method" => "HMAC-SHA1",
      "oauth_timestamp" => Time.now.getutc.to_i.to_s,
      "oauth_version" => "1.0"
    }
    sig = signature_base_string('POST', base_uri, header)
    header["oauth_signature"] = sign('nknks', sig)
    header['Content-Type'] = 'application/json' 
    header['X-Target-URI'] = "https://bitbucket.org"
    header["Connection"] = "Keep-Alive"
    header["Host"] = "bitbucket.org"
    header
  end
  

  def request
    if current_user
      base_uri = "https://bitbucket.org/api/2.0/repositories/" + current_user.uid + '/tasklist'
      response = HTTParty.get(base_uri, :headers => headers)
    end
  end

  def nonce
    rand(10 ** 30).to_s.rjust(30,'0')
  end

  def sign( key, base_string )
    digest = OpenSSL::Digest::Digest.new( 'sha1' )
    hmac = OpenSSL::HMAC.digest( digest, key, base_string  )
    Base64.encode64( hmac ).chomp.gsub( /\n/, '' )
  end

  def signature_base_string(method, uri, params)
    encoded_params = params.sort.collect{ |k, v| url_encode("#{k}=#{v}") }.join('%26')
    method + '&' + url_encode(uri) + '&' + encoded_params
  end

  def url_encode(string)
    CGI::escape(string)
  end
end