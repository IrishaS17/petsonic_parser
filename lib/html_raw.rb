require 'nokogiri'
require 'open-uri'
#require 'httparty'

module Reader
  def Reader.html_reader url
  	#http = HTTParty.get(url)
   	#html = Nokogiri::HTML(http.body) 
	  html = Nokogiri::HTML(open(url))
  end

  def Reader.get_info_by_xpath(html, path)
    html.xpath(path)
  end
end