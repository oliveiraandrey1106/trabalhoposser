require 'net/http'
require 'uri'
require 'json'

class Translator
    def initialize
        @uri = URI.parse("https://api.gotit.ai/Translation/v1.1/Translate")
        @request = Net::HTTP::Post.new(@uri, 'Content-Type' => 'application/json')
        @request.basic_auth("1995-iOzB66VV", "fdCsmSc/a+XsuV1OSqLDVj7eLR/cNydUsLfqf23QS0qq")
    end

    def translate(message, from, to)
        @request.body = {T: message, SL: from, TL: to}.to_json
        response = Net::HTTP.start(@uri.hostname, @uri.port, use_ssl: @uri.scheme == "https") do |http|
            http.request(@request)
        end

        request_json = JSON.parse(@request.body)
        response_json = JSON.parse(response.body)
        log(request_json, response_json)
        
        return response_json["result"]
    end

    def log(request, response)
        time = Time.new
        message = request["T"]
        from = request["SL"]
        to = request["TL"]
        translate = response["result"]

        file = File.open(time.strftime("%m-%d-%Y.%H.%M.%S") + ".txt", 'w') do |fline|
            fline.puts ("From: #{from}")
            fline.puts ("To: #{to}")
            fline.puts ("Message: #{message}")
            fline.puts ("Translate: #{translate}")
        end
    end
end
 
