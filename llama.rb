require 'net/http'
require 'uri'
require 'json'
require 'yaml'
  
api_key = YAML.load_file('data.yml')

loop do
uri = URI.parse("https://openrouter.ai/api/v1/chat/completions")
request = Net::HTTP::Post.new(uri)
request.content_type = "application/json"
        puts "<Ask Llama AI>"
        ask = gets.chomp
request["Authorization"] = "Bearer #{api_key['token_openrouter']}"
request.body = JSON.dump({
  "model" => "meta-llama/llama-3.3-70b-instruct",
  "messages" => [
    {
      "role" => "user",
      "content" => "#{ask}"
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
        puts "Answer = #{load['choices'][0]['message']['content']}"
end