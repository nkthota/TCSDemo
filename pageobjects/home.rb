require 'rspec'
require 'selenium-webdriver'

class HomePage < AbstractPage

  #define object name for all page objects
  attr_accessor :edit_search, :button_search

  #intialize the selector strings for all the objects defined
  def initialize(driver)
    super(driver)
    @edit_search = "input[name='Ntt']"
    @button_search = "button[class='blue-button search-button']"
  end

  # the object name and the initialization will come from the chrome extension to save time

  # Handle promotion and email sign up popup control
  def closePromotionPopUp()
    @@gblErrorCode = ''
    wait = Selenium::WebDriver::Wait.new(:timeout => @@gblTimeout) # seconds
    begin
      @@driver.execute_script("if(document.getElementsByTagName('area')[1] != null){if(document.getElementsByTagName('area')[1].href.indexOf('#close') != -1){document.getElementsByTagName('area')[1].click();}}")
      browserSync()
      sleep(5)
    rescue Exception => e
      puts e.message
      @@gblErrorCode = e.message
    end
    return @@gblErrorCode
  end


end