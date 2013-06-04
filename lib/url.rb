# coding: utf-8

require 'net/http'
require 'uri'

class ValidationError < StandardError; end

class InvalidUriSchemeError < ValidationError; end
class InvalidUriStatusError < ValidationError; end

class UriValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    raise URI::InvalidURIError unless value =~ /^#{URI::regexp}$/

    url = URI.parse(value)
    raise InvalidUriSchemeError unless url.kind_of?(URI::HTTP)

    request = Net::HTTP.new(url.host, url.port)
    request.read_timeout = 3
    response = request.request_head(url.request_uri)
    raise InvalidUriStatusError unless response.code == '200'
  rescue URI::InvalidURIError
    object.errors[attribute] << (options[:message] || 'invalid uri')
  rescue Errno::ENOENT
    object.errors[attribute] << (options[:message] || 'invalid url')
  rescue InvalidUriSchemeError
    object.errors[attribute] << (options[:message] || 'invalid scheme')
  rescue InvalidUriStatusError
    object.errors[attribute] << (options[:message] || 'invalid status')
  rescue Timeout::Error
    object.errors[attribute] << (options[:message] || 'invalid timeout')
  end
end
