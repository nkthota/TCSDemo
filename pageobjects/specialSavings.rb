require 'rspec'
require 'selenium-webdriver'

class SpecialSavings < AbstractPage

  #define object name for all page objects
  attr_accessor :select_items

  #intialize the selector strings for all the objects defined
  def initialize(driver)
    super(driver)
    @select_items = "[name='rpp']"
  end

  def navigatetosalespage()
    @@driver.navigate.to 'http://www.containerstore.com/shop/specialSavings'
    wait = Selenium::WebDriver::Wait.new(:timeout => 100)
    wait.until { @@driver.title.downcase.start_with? "special savings" }
  end

  # verify all sale item price to make sure the sale price is < actual price
  def verifyitemsprice()
    begin
      divelements = @@driver.find_elements(:css , "div[class='mobile-grid-70']")
      if divelements.length != 0
        for objDiv in divelements
          objsaleprice = objDiv.find_elements(:css , "p[class='salePrice']")
          objactualprice = objDiv.find_elements(:css , "p[class='price']")
          if objsaleprice.length == 1 && objactualprice.length == 1
            if objactualprice[0].text.scan(/\d+.+\d+/)[0].to_f > objsaleprice[0].text.scan(/\d+.+\d+/)[0].to_f
              puts objDiv.text + '- Passed'
            else
              puts objDiv.text + '- Failed'
            end
          else
            puts 'No sale price for item ' + objDiv.text
          end
        end
      else
        puts "Sale items grid table not found with the given selectors" + '- Failed'
      end
    rescue Exception => e
      puts e.message + '- Failed'
    end
  end

end