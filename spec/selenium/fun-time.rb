describe "SeleniumFunTime" do
  include DuckDuckSlow

  before(:each) do
    get_driver
  end
  
  after(:each) do
    bye_driver
  end
  
  it "test_selenium_fun_time" do
    get_to_the_duck
    prove_the_duck(read_the_duck_by_css_selector("i"), "Selenium automates browsers")
  end
end
