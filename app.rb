require "sinatra"
require "sinatra/reloader"
require "http"
require 'net/http'
require "json"



get("/") do
  @url = "https://api.exchangerate.host/symbols"
  @raw_response = HTTP.get(@url)
  @parsed_response = JSON.parse(@raw_response)
  @my_hash = @parsed_response.fetch("symbols")
  erb(:currency_pairs)
end

@url = "https://api.exchangerate.host/symbols"
@raw_response = HTTP.get(@url)
@parsed_response = JSON.parse(@raw_response)
@my_hash = @parsed_response.fetch("symbols")

@my_hash.each do |keys, values|
  get("/#{keys}") do
    @k = keys
    @url = "https://api.exchangerate.host/symbols"
    @raw_response = HTTP.get(@url)
    @parsed_response = JSON.parse(@raw_response)
    @mh = @parsed_response.fetch("symbols")
    erb(:convert)
  end
end

# @url2 = "https://api.exchangerate.host/latest"
# @raw_response2 = HTTP.get(@url2)
# @parsed_response2 = JSON.parse(@raw_response2)
# @my_hash2 = @parsed_response2.fetch("rates")


@my_hash.each do |keys, values|
  @my_hash.each do |keys2, values2|
    get("/#{keys}/#{keys2}") do
      # @url = "https://api.exchangerate.host/symbols"
      # @raw_response = HTTP.get(@url)
      # @parsed_response = JSON.parse(@raw_response)
      # @mh = @parsed_response.fetch("symbols")

      @url2 = "https://api.exchangerate.host/latest"
      @raw_response2 = HTTP.get(@url2)
      @parsed_response2 = JSON.parse(@raw_response2)
      @symbol_rates = @parsed_response2.fetch("rates")

      @keys_value = @symbol_rates.fetch(keys)
      @keys2_value = @symbol_rates.fetch(keys2)

      @k = keys
      @k2 = keys2

      @rate = @keys2_value / @keys_value
      @rate = @rate.round(6)
      erb(:convert_second)

    end
  end
end
