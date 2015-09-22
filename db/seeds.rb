require "net/http"
require "uri"
require "csv"
require 'pry'

#site url: http://www.cocktails.eu/alphabetical/index.php?letter=a


@pagination_numbers = [17, 37, 35,  13,  5,  18,  17, 13, 6, 8, 7, 13, 21, 7, 6, 18, 1, 12, 25, 16, 1, 4, 7, 1, 2,  1]
@pagination_letters = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]

def each_page_letter(letter)
	Net::HTTP::Get.new("/alphabetical/index.php?letter=#{letter}", {"User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.130 Safari/537.36"})
end

site_url = "www.cocktails.eu"
@http = Net::HTTP.new(site_url)

def create_csv_file
	index = 0
	@pagination_letters.each do |letter|
		print letter
		@pagination_numbers[index].times do |pages|
			print pages
			sleep(1)
			page_request = each_page_letter("#{letter}&i=#{pages+1}")
			page_response = @http.request(page_request)
			open("cocktail_recipes_index.html", "a+") do |i|
				i.puts page_response.body.parameterize + "\n"
			end
		end
		index += 1
	end
end

create_csv_file
@cocktail_recipes = Nokogiri::HTML(File.open("cocktail_recipes_index.html"))

@cocktail_ingredients = []

@cocktail_recipes.css(".list_head").each do |link|
  correct_element = link.next_sibling.next_sibling
  correct_element.text.scan(/, .+,/).each do |item|
  	item.gsub!(/ with/, "")
  	item.gsub!(/\p{S}/, "")
  	@cocktail_ingredients << item.slice(2..-2)
  end
  correct_element = correct_element.text.gsub(/\p{S} /, "")
  puts correct_element
  last_two_items = correct_element.scan(/, \w+\-*\.*\s*\&*\w*\-*\.*\s*\&*\w*\-*\.*\s*\&*\w*\-*\.*\s*\&*\w*\-*\.*\s*\&*\w*\-*\.*\s*\&*\w*\-*\.*\s*\w*and .+./).first #accommodates ingredients with up to seven words between commas and the end of the sentence
  if last_two_items == nil 
  	last_two_items = correct_element.scan(/, \w+\s\w+\s\w+$/).first #to check for edge case of no period and no "and"
  end
  @cocktail_ingredients << last_two_items.scan(/, \w+\s*\w*\s*\w*\s*\w*\s*\w* and/).slice(2..-5)
 	@cocktail_ingredients << last_two_items.scan(/and \w+\s*\w*\s*\w*\s*\w*\s*\w*./).slice(4..-2) #edge case when ingredient has "and" in it
end

@cocktail_ingredients.uniq!

@cocktail_ingredients.each do |ingredient|
	Ingredient.create!(ingredient)
end

@cocktail_recipes.css(".list_head").each do |name|
  Cocktail.create!({name: name.text, link: site_url + name['href']})
end

