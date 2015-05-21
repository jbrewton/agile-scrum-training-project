module DuckDuckSlow
  require "json"
  require "selenium-webdriver"
  require "rspec"
  include RSpec::Expectations

  def get_driver
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "https://www.google.com/"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end

  def bye_driver
    @driver.quit
    @verification_errors.should == []
  end

  def get_to_the_duck
    @driver.get(@base_url + "/search?q=duckduckgo&ie=utf-8&oe=utf-8")
    @driver.find_element(:link, "DuckDuckGo").click
    @driver.find_element(:id, "search_form_input_homepage").clear
    @driver.find_element(:id, "search_form_input_homepage").send_keys "selenium"
    @driver.find_element(:id, "search_button_homepage").click
    @driver.find_element(:link, "Selenium - Web Browser Automation").click
  end

  def read_the_duck_by_css_selector(selector)
    @driver.find_element(:css, selector).text
  end

  def prove_the_duck(actual, expected)
    verify { (actual).should == expected }
  end

  def element_present?(how, what)
    @driver.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end
  
  def alert_present?()
    @driver.switch_to.alert
    true
  rescue Selenium::WebDriver::Error::NoAlertPresentError
    false
  end
  
  def verify(&blk)
    yield
  rescue ExpectationNotMetError => ex
    @verification_errors << ex
  end
  
  def close_alert_and_get_its_text(how, what)
    alert = @driver.switch_to().alert()
    alert_text = alert.text
    if (@accept_next_alert) then
      alert.accept()
    else
      alert.dismiss()
    end
    alert_text
  ensure
    @accept_next_alert = true
  end
end