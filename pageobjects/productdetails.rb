require 'rspec'
require 'selenium-webdriver'
class ProductDetails < AbstractPage

  #define object name for all page objects
  attr_accessor :table_sellableitems

  #intialize the selector strings for all the objects defined
  def initialize(driver)
    super(driver)
    @table_sellableitems = "table[class='sellableItems gutter-bottom-double']"
  end

  def findproductsellableitem(itemnumber)
    itemflag = false
    itemprice = ""
    tableelements = @@driver.find_elements(:css , @table_sellableitems)
    tablerowelements = tableelements[0].find_elements(:css , "tr")
    for objtr in tablerowelements
      if objtr.text.to_s.include? itemnumber.to_s
        itemprice = @@driver.execute_script("return arguments[0].querySelector(\"span[itemprop='price']\")" , objtr).text
        itemflag = true
        break
      end
    end
    if itemflag == true
      puts 'Item number ' + itemnumber.to_s + ' is displayed in the sellable grid with price ' + itemprice.to_s
    else
      puts 'Item number ' + itemnumber.to_s + ' is not displayed in the sellable grid'
    end
  end

end