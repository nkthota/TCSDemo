# Abstract Class for all page objects
require 'rspec'
require 'selenium-webdriver'

class AbstractPage

  @@driver = nil
  @@gblErrorCode = ''
  @@gblTimeout = 60

  # Initialize the abstract class with any global variables
  def initialize (driver)
    @@driver = driver
    @@gblErrorCode = ''
  end

  # Navigate to a given page url
  def navigatetopage(url , title)
    @@driver.navigate.to url
    wait = Selenium::WebDriver::Wait.new(:timeout => @@gblTimeout)
    wait.until { @@driver.title.downcase.start_with? title }
  end

  # Edit control set value base on the CSS selector
  def setValue(css_selector , value)
    @@gblErrorCode = ''
    wait = Selenium::WebDriver::Wait.new(:timeout => @@gblTimeout) # seconds
    begin
      element = wait.until { @@driver.find_element(:css , css_selector) }
      element.send_keys value
    rescue Exception => e
      puts e.message
      @@gblErrorCode = e.message
    end
    return @@gblErrorCode
  end

  # Select control select value base on the CSS selector
  def selectValue(css_selector , value)
    @@gblErrorCode = ''
    wait = Selenium::WebDriver::Wait.new(:timeout => @@gblTimeout) # seconds
    begin
      option = wait.until {Selenium::WebDriver::Support::Select.new(@@driver.find_element(:css , css_selector))}
      option.select_by(:text, value)
      browserSync()
    rescue Exception => e
      puts e.message
      @@gblErrorCode = e.message
    end
    return @@gblErrorCode
  end

  # CLick on element specified by CSS selector
  def click(css_selector)
    @@gblErrorCode = ''
    wait = Selenium::WebDriver::Wait.new(:timeout => @@gblTimeout) # seconds
    begin
      element = wait.until { @@driver.find_element(:css , css_selector) }
      element.click()
      browserSync()
    rescue Exception => e
      puts e.message
      @@gblErrorCode = e.message
    end
    return @@gblErrorCode
  end

  # getter for the global error message
  def getErrorDetails
    return @@gblErrorCode
  end

  # Browser navigation sync
  def browserSync(timeout=60)
    begin
      wait = Selenium::WebDriver::Wait.new(:timeout => timeout)
      wait.until {
        @@driver.execute_script("return document.readyState;") == "complete"
        sleep(2)
      }
    rescue Exception => e
      puts e.message
      @@gblErrorCode = e.message
    end
  end

end