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

  # extend the methods from the


end