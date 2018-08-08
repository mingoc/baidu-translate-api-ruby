
require 'digest'
require 'json'
require 'open-uri'
require 'uri'

class BaiduTranslateApi
  VERSION = '0.1.0'

  SALT_MAXNUM = 10000000
  HTTP_ENDPOINT = 'http://api.fanyi.baidu.com/api/trans/vip/translate'
  HTTPS_ENDPOINT = 'https://fanyi-api.baidu.com/api/trans/vip/translate'

  attr_accessor :appid, :secret_key, :default_from, :default_to, :use_https
  def initialize(appid:, secret_key:, default_from: :auto, default_to: :zh, use_https: true)
    @appid = appid
    @secret_key = secret_key
    @default_from = default_from
    @default_to = default_to
    @use_https = use_https
  end

  def request(word, from: self.default_from, to: self.default_to)
    if word.bytesize > 6000
      raise AugumentsError.new("word bytesize over 6000, https://api.fanyi.baidu.com/api/trans/product/apidoc")
    end
    salt = rand(SALT_MAXNUM).to_s
    q = word
    sign = Digest::MD5.hexdigest "#{self.appid}#{q}#{salt}#{self.secret_key}"
    params = {
      salt: salt,
      q: q,
      to: to,
      from: from,
      appid: self.appid,
      sign: sign,
    }
    open(endpoint + '?' + URI.encode_www_form(params))
  end

  def translate(word, from: self.default_from, to: self.default_to)
    res = request(word, from: from, to: to)
    data = JSON.parse(res.read)
    data['trans_result'].map {|d| d['dst'] }.join("\n")
  end

  def endpoint
    if self.use_https
      HTTPS_ENDPOINT
    else
      HTTP_ENDPOINT
    end
  end
end

