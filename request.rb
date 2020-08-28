require('uri')
require('net/http')
require('openssl')
require('json')

def request(url, api_key)
    url = URI(url + api_key)
    http = Net::HTTP.new(url.host, url.port)
    request = Net::HTTP::Get.new(url)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    response = http.request(request)
    unless (response.code.to_i / 100) == 2
        return nil
    else
        return JSON.parse(response.read_body)
    end
end