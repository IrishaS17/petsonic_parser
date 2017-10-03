require_relative 'html_raw'

class ProductParser
  include Reader
  
  TITLE_XPATH = '//*/div[@class="product-name"]/h1/text()'
  IMAGE_XPATH = '//*/span[@id="view_full_size"]/img/@src'
  WEIGHT_XPATH = '//*/span[@class="attribute_name"]'
  PRICE_XPATH = '//*/span[@class="attribute_price"]'
  ONE_PRICE_XPATH = '//*/span[@id="our_price_display"]'

  def initialize href
    @html = Reader::html_reader(href)
  end

  def get_title
    Reader::get_info_by_xpath(@html, TITLE_XPATH).text.lstrip
  end

  def get_image
    Reader::get_info_by_xpath(@html, IMAGE_XPATH).text()
  end

  def get_price path
    Reader::get_info_by_xpath(@html, path)
  end

  def price_to_s price
    price.text.strip.chomp('€')
  end

  def get_weight
    Reader::get_info_by_xpath(@html, WEIGHT_XPATH)
  end

  def title_with_weight title, weight
    product_name = title + " - " + weight.text.chomp(".")
  end
 
  def many_weight title, weight
    product_name=[]
    weight.children.each do |w|
      product_name << title_with_weight(title, w)
    end
    return product_name
  end

  def many_prices price
	  product_price = []
	  price.children.each do |pr|
	    product_price.push << price_to_s(pr)
	  end
	  
	  return product_price
  end

  def set_info title, price, image
    product_info = []
    product_info.push(
      title: title,
      price: price,
      image: image
    )
  end

  def many_product_properties title, weight, price, image
    product_name = many_weight(title, weight)
    product_price = many_prices(price)
    product_info = []
    for i in 0...product_name.size
    	title = product_name[i]
    	price = product_price[i]
      product_info << set_info(title, price, image)
    end
    return product_info 
  end

  def parse_product  
	  title = get_title
	  image = get_image
	  weight = get_weight
	  price = get_price(PRICE_XPATH)
	  if weight.size == 0
	    price = price_to_s(get_price(ONE_PRICE_XPATH))
	  elsif weight.size == 1 
	    title = title_with_weight(title, weight)
	    price = price_to_s(price)
	  end
	  if weight.size > 1
	  	many_product_properties(title, weight, price, image)
	  else
	  	set_info(title, price, image)
	  end 
	end

end