require 'rest-client'

class MyRestClient

  attr_reader :response

  def initialize
    @response = ""
  end

  def search_google(param)
    begin
      @response = RestClient.get "http://www.google.com/search", { :params => { :q => param} }
    rescue RestClient::ResourceNotFound => err
      puts "Response code: #{err.message}"
    end
  end


  def get_wiki_article(param)
    begin 
      @response = RestClient.get "http://en.wikipedia.org/wiki/#{param}"
    rescue RestClient::ResourceNotFound => err
      puts "Response code: #{err.message}"
    end
  end

  def search_amazon(param)
    begin
      @response = RestClient.get "http://www.amazon.com/s/ref=nb_sb_noss", { :params => { "field-keywords" => param } }
    rescue RestClient::ResourceNotFound => err
      puts "Response code: #{err.message}"
    end
  end

  def print_response
    puts ""
    puts "Response code: #{@response.code}" 
    puts ""
    puts "Response headers: #{@response.headers}"
    puts ""
    puts "Response cookies: #{@response.cookies}"
    puts ""
    puts "Response body: #{@response.to_str}"
  end

end


rest_client = MyRestClient.new
puts "***  Rest Client  ***"
puts ""
puts "Please select an option: "
puts ""
puts "     1. Search in Google"
puts "     2. Get article from Wikipedia"
puts "     3. Search in Amazon"
puts ""
option = gets.chomp
while !option.to_i.between?(1,3)
  puts "The option selected is invalid. Tray again: "
  option = gets.chomp
end
print "Please enter your input: "
input = gets.chomp

case option
when "1" then rest_client.search_google(input)
when "2" then rest_client.get_wiki_article(input)
when "3" then rest_client.search_amazon(input)
end

rest_client.print_response if !rest_client.response.empty?
