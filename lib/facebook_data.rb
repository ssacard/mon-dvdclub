require 'openssl'
require 'base64'

module FacebookData
  def get_facebook_params( params )
    if params.is_a? Hash
      signed_request = params.delete 'signed_request'
    else
      signed_request = params
    end

    signature, signed_params    = signed_request.split '.'
    signed_params               = Yajl::Parser.new.parse base64_url_decode( signed_params )

    { :signature => signature, :signed_params => signed_params }
  end

  def signed_request_is_valid?( secret, signature, params )
    signature = base64_url_decode signature 
    expected_signature = OpenSSL::HMAC.digest 'SHA256', secret, params.tr( "-_", "+/" )
    signature == expected_signature
  end

  def base64_url_decode( str )
    str = str + "=" * ( 6 - str.size % 6 ) unless str.size % 6 == 0
    Base64.decode64 str.tr( "-_", "+/" ) 
  end
end
