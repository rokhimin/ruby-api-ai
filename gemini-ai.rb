require 'open-uri'
require 'net/http'
require 'json'
require 'yaml'
  
api_key = YAML.load_file('data.yml')

  loop do
    uri = URI.parse("https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=#{api_key['api_key_gemini']}
    ")
      request = Net::HTTP::Post.new(uri)
      request.content_type = "application/json"
        puts "<Ask Gemini AI>"
        ask = gets.chomp
      request.body = JSON.dump({
        "contents" => [
          {
            "parts" => [
              {
                "text" => "#{ask}"
              }
            ]
          }
        ]
      })
     
      req_options = {
        use_ssl: uri.scheme == "https",
      }
     
      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end
      load = JSON.parse(response.body)
     
        #puts "Status = #{response.code}"
        puts "Answer = #{load['candidates'][0]['content']['parts'][0]['text']}"


  end

