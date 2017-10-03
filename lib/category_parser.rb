require_relative 'html_raw'
require_relative 'product_to_csv'
require_relative 'product_parser'

class CategoryParser
  include Reader

   PRODUCT_URL_XPATH = "//*/div[@class='product-meta-title']/h5/a"
   ALL_PRODUCTS_PAGE_XPATH = "//*/*[@class='showall pull-left']/div/input"
  
	def initialize url
	  @url = url
    @html = Reader::html_reader(url)
	end

  def get_all_pages 
    all_products = Reader::get_info_by_xpath(@html, ALL_PRODUCTS_PAGE_XPATH)
    if !all_products.nil?
		  path = "?"
		  all_products.each do |x|
		    path += x['name'] + '=' + x['value'] + "&"
		  end
		  @url += path
		  @html = Reader::html_reader(@url) 
		end
  end

  def parse_page file_name
  	get_all_pages
    nodes = Reader::get_info_by_xpath(@html, PRODUCT_URL_XPATH)
    products = []
    puts "I found #{nodes.size()} products"
		nodes.each do |a|	
		  products << ProductParser.new(a['href']).parse_product
		end
		ProductToCsv.new(file_name).write_to_csv(products)
  end

end