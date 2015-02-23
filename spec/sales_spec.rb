require 'rspec'
require 'spec_helper'
require 'selenium-webdriver'
require 'tiny_tds'
require 'json'
require_relative '../pageobjects/abstractpage'
require_relative '../pageobjects/specialSavings'
require_relative '../pageobjects/ProductDetails'
require_relative '../pageobjects/home'
require_relative '../lib/datadriver'


describe 'The Container Store Sales' do

  # Initialize the driver with the target browser
  before(:all) do
    @driver = Selenium::WebDriver.for(:firefox)
    @driver.manage.timeouts.implicit_wait = 30
  end

  it 'sale price from special savings page must have sales price less than actual price' do
    salepage = SpecialSavings.new(@driver)
    #Navigate to sales page
    salepage.navigatetosalespage()
    sleep(5)
    salepage.closePromotionPopUp()
    # select view all items
    salepage.selectValue(salepage.select_items , "View All")
    # verify each item prices
    salepage.verifyitemsprice()
  end


  describe "verify the sale price for the given items", :current => true do
    datadriver = DataDriver.new()
    parsed = JSON.parse(datadriver.gettestdata(1))
    parsed["data"].each do |param|
      it "Verify SKU Price"  do
        homepage = HomePage.new(@driver)
        homepage.navigatetopage('http://www.containerstore.com/welcome.htm' , 'the container store')
        homepage.closePromotionPopUp()
        homepage.setValue(homepage.edit_search , param['item'])
        homepage.click(homepage.button_search)
        proddetails = ProductDetails.new(@driver)
        proddetails.findproductsellableitem(param['item'])
      end
    end
  end

  # clean driver after all tests
  after(:all) do
    @driver.quit
  end
end