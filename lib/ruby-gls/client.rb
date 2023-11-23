require 'rest-client'
require 'json'
require "base64"

class RubyGLS::Client
  
  attr_reader :base_url, :basic_auth, :username, :password, :contact_id

  def initialize(base_url, basic_auth, username, password, contact_id)
    @base_url = base_url
    @basic_auth = basic_auth
    @username = username
    @password = password
    @contact_id = contact_id

    raise ArgumentError('Either basic_auth or username and password not provided') unless basic_auth || (username && password)
  end

  def action(path, http_method: :post, payload: {})
    begin 
      response = ::RestClient::Request.execute(
        method: http_method,
        url: full_url(path),
        payload: payload.to_json,
        headers: headers,
        timeout: 5,
        verify_ssl: ::OpenSSL::SSL::VERIFY_NONE
      )
    rescue => e
      return struct_response.new(false, { error: e.message, headers: e.response.headers })
    end

    parse(response)
  end

  def get_basic_auth
    return basic_auth if basic_auth

    Base64.encode64("#{username}:#{password}")
  end

  def headers
    {
      'User-Agent': "RubyGLS client v#{RubyGLS::VERSION})",
      'Content-Type': 'application/glsVersion1+json',
      'Accept': 'application/glsVersion1+json, application/json',
      'Authorization': "Basic #{get_basic_auth}"
    }
  end

  def full_url(path)
    "#{base_url}#{path}"
  end

  def parse(response)
    success       = (200..308).to_a.include?(response.code.to_i) ? true : false
    hash_response = JSON.parse(response.body)

    struct_response.new(success, hash_response)
  end

  def struct_response

    Struct.new(:success?, :hash_response)
  end
end