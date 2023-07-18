require "http"
require 'net/http'
require "json"



@url = "https://api.exchangerate.host/latest"
@raw_response = HTTP.get(@url)
@parsed_response = JSON.parse(@raw_response)

@my_hash = @parsed_response.fetch("rates")
pp @my_hash
