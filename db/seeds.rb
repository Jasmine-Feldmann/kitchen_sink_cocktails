require "net/http"
require "uri"
require "csv"
require 'pry'

#site url: http://www.cocktails.eu/alphabetical/index.php?letter=a


@pagination_numbers = [17, 37, 35,  13,  5,  18,  17, 13, 6, 8, 7, 13, 21, 7, 6, 18, 1, 12, 25, 16, 1, 4, 7, 1, 2,  1]
@pagination_letters = ["a", "b", "c", "d", "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y", "z"]

def each_page_letter(letter)
	Net::HTTP::Get.new("/alphabetical/index.php?letter=#{letter}", {"User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.130 Safari/537.36"})
end

site_url = "www.cocktails.eu"
@http = Net::HTTP.new(site_url)

def create_csv_file
	index = 0
	@pagination_letters.each do |letter|
		@pagination_numbers[index].times do |pages|
			sleep(1)
			page_request = each_page_letter("#{letter}&i=#{pages+1}")
			page_response = @http.request(page_request)
			open("cocktail_recipes.html", "a+") do |i|
				i.puts page_response.body + "\n"
			end
		end
		index += 1
	end
end

create_csv_file
@cocktail_recipes = Nokogiri::HTML(File.open("cocktail_recipes.html"))


@ingredients = @cocktail_recipes.css(".list_head").map do |link|
  cocktail_ingredients = []
  correct_element = link.next_sibling.next_sibling
  correct_element.text.scan(/,\.+,/).each do |item|
  	item.gsub(/ with/, "")
  	item.gsub(/\p{S}/, "")
  	cocktail_ingredients << item.slice(2..-2)
  end
  last_two_items = correct_element.text.scan(/, \w+\s*\w*\s*\w*\s*\w*\s*\w* and .+./) #accommodates ingredients with up to five words
  last_two_items.gsub(/\p{S}/, "")
  cocktail_ingredients << last_two_items.scan(/, \w+\s*\w*\s*\w*\s*\w*\s*\w* and/).slice(2..-5)
 	cocktail_ingredients << last_two_items.scan(/and \w+\s*\w*\s*\w*\s*\w*\s*\w*./).slice(4..-2)
end

@ingredients.uniq!

@ingredients.each do |ingredient|
	Ingredient.create!(ingredient)
end

@cocktail_recipes.css(".list_head").each do |name|
  Cocktail.create!({name: name.text, link: site_url + name['href']})
end
