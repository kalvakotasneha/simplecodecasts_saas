require 'rubygems'
require 'watir-webdriver'
require 'watir-webdriver/extensions/alerts'
require 'colorize'
require 'mysql2'

require 'ffaker'

$username = FFaker::Name.name       #=> "Christophe Bartell"
$useremail = FFaker::Internet.email  #=> "kirsten.greenholt@corkeryfisher.info"
$userFirstName=FFaker::Name.first_name
$userLastName=FFaker::Name.last_name

#$webURL = 'https://coder-manual-rails-snehakalvakota.c9.io/'
$webURL = 'http://polar-shelf-9487.herokuapp.com/'

browser = Watir::Browser.new

#Scenario: User should be able to access Dev Match URL
Given(/^DevMatch website URL is provided$/) do
  browser.goto $webURL
end

When(/^User accesses DevMatch website$/) do
  if browser.url == $webURL
    puts "Url is loaded successfully".green
  else
    puts "error unable to load Url".red
  end
end


Then(/^DevMatch website should be loaded$/) do
  if browser.text.include? "Welcome to Dev Match"
    puts "successfully loaded".green
  else
    puts "error unable to load".red
  end
end


# Scenario: User should be able to "Sign up with basic"
Given(/^Basic Button is available in Home Page$/) do
  if browser.link(:href,"/users/sign_up?plan=1").exists?
    puts "Sign up button is visible".green
  else
    puts "error Signup button not visible".red
  end
end


When(/^User clicks Basic Button$/) do
  browser.link(:href,"/users/sign_up?plan=1").click
end

When(/^User enters email information$/) do
  browser.text_field(:id,"user_email").set($useremail)
  puts "Basic user Email : " + $useremail
end

Then(/^User can enter password$/) do
  browser.text_field(:id,"user_password").set("password")
end

Then(/^User can confirm password$/) do
  browser.text_field(:id,"user_password_confirmation").set("password")
end

Then(/^User should successfully signup$/) do
  browser.button(:value,"Sign up").click
  if browser.text.include? "Welcome! You have signed up successfully."
    puts "successfully signed up".green
  else
    puts "error unable to signup".red
  end
  browser.button(:value,"Sign Out").click
end


#Scenario: User should be able to log in dev match with valid email and password

Given(/^User should able to access DevMatch login page$/) do
  browser.goto $webURL + "users/sign_in"
end

When(/^User enters email and password to login$/) do
  browser.text_field(:id,"user_email").set($useremail)
  browser.text_field(:id,"user_password").set("password")
  browser.button(:value,"Log in").click
end

Then(/^User succesfully logs in$/) do
  if browser.text.include? "Signed in successfully."
    puts "successfully logged in".green
  else
    puts "error unable to log in".red
  end
end

#  Scenario: Basic User should able to visit profile
Given(/^Basic User is logged in with valid email$/) do
  if browser.button(:value,"Sign Out").exists?
    puts "User already logged in"
  else
    browser.goto $webURL + "users/sign_in"
    puts "Basic User Email : "+ $useremail
    browser.text_field(:id,"user_email").set($useremail)
    browser.text_field(:id,"user_password").set("password")
    browser.button(:value,"Log in").click
  end
end

When(/^Basic User clicks create profile$/) do
  browser.link(:href,/\/users\/\d+\/profile\/new/).click
end

$basicavatarfilepath = 'C:\row\Cucumber_tests_DevMatch\female-avatar.jpg'
When(/^Basic User fills out create profile form$/) do
  browser.text_field(:id,"profile_first_name").set($userFirstName)
  browser.text_field(:id,"profile_last_name").set($userLastName)
  browser.file_field(:id,"profile_avatar").set($basicavatarfilepath)
  browser.select_list(:id,"profile_job_title").select 'Developer'
  browser.text_field(:id,"profile_phone_number").set(FFaker::PhoneNumber.phone_number)
  browser.text_field(:id,"profile_contact_email").set($useremail)
  browser.text_field(:id,"profile_description").set(FFaker::HipsterIpsum.paragraph)
  browser.button(:value,"update profile").click
end

When(/^Basic User clicks View profile$/) do
  browser.goto $webURL
  browser.link(:href,/\/users\/\d+/).click
end

Then(/^Basic user can view his profile$/) do
  browser.text.include? "Description"
end

Then(/^User signs out$/) do
  browser.button(:value,"Sign Out").click
end

# Scenario: User should be able to "Signup with pro"

Given(/^Pro Button is available in home page$/) do
  if browser.link(:href,"/users/sign_up?plan=2").exists?
    puts "Sign up button is visible".green
  else
    puts "error Signup button not visible".red
  end
end

When(/^User clicks Pro Button$/) do
  browser.link(:href,"/users/sign_up?plan=2").click
end
$proUserEmail = FFaker::Internet.email
$proUserFirstName = FFaker::Name.first_name
$proUserLastName=FFaker::Name.last_name
When(/^Pro user enter email information$/) do
puts $proUserEmail
  browser.text_field(:id,"user_email").set($proUserEmail)
end

Then(/^Pro User can enter password$/) do
  browser.text_field(:id,"user_password").set("password")
end

Then(/^Pro User can confirm password$/) do
  browser.text_field(:id,"user_password_confirmation").set("password")
end

Then(/^User enters Credit Card Number$/) do
  browser.text_field(:id,"card_number").set("4242424242424242")
end

Then(/^User enters Security Code on Card \(CVC\)$/) do
  browser.text_field(:id,"card_code").set(FFaker::CreditCard.cvv)
end

Then(/^User Card Expiration$/) do
  browser.select_list(:id,"card_month").select '3 - March'
  browser.select_list(:id,"card_year").select '2020'
end

Then(/^User should click Sign up$/) do
  browser.button(:value,"Sign up").click
  sleep 5
  if browser.text.include? "Welcome! You have signed up successfully."
    puts "successfully signed up".green
  else
   puts "error unable to signup".red
  end
end
#  Scenario: User should able to visit profile
Given(/^Pro User is logged in with valid email$/) do
  if browser.button(:value,"Sign Out").exists?
    puts "User already logged in"
  else
    browser.goto $webURL + "users/sign_in"
    puts "Pro User Email : "+ $proUserEmail
    browser.text_field(:id,"user_email").set($proUserEmail)
    browser.text_field(:id,"user_password").set("password")
    browser.button(:value,"Log in").click
  end
end

When(/^Pro User clicks create profile$/) do
  browser.link(:href,/\/users\/\d+\/profile\/new/).click
end

$proavatarfilepath = 'C:\row\Cucumber_tests_DevMatch\entrepreneur-avatar.jpg'
When(/^Pro User fills out create profile form$/) do
  browser.text_field(:id,"profile_first_name").set($proUserFirstName)
  browser.text_field(:id,"profile_last_name").set($proUserLastName)
  browser.file_field(:id,"profile_avatar").set($proavatarfilepath)
  browser.select_list(:id,"profile_job_title").select 'Investor'
  browser.text_field(:id,"profile_phone_number").set(FFaker::PhoneNumber.phone_number)
  browser.text_field(:id,"profile_contact_email").set($proUserEmail)
  browser.text_field(:id,"profile_description").set(FFaker::HipsterIpsum.paragraph)
  browser.button(:value,"update profile").click
end

When(/^Pro User clicks View profile$/) do
  browser.goto $webURL
  browser.link(:href,/\/users\/\d+/).click
end

Then(/^Pro user can view his profile$/) do
  browser.text.include? "Description"
end

#Scenario: User should able to visit the community
Given(/^logged with valid email$/) do
  browser.goto $webURL
end

When(/^user clicks visit the community button$/) do
  browser.link(:href,"/users").click
end

Then(/^User can visit community with different profiles$/) do
    if browser.text.include?"Dev Match Community"
      puts "successfully logged in".green
    else
      puts "error unable to log in".red
    end
    browser.button(:value,"Sign Out").click
  browser.close
end