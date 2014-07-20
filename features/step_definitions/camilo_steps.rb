Given(/^I fill in "(.*?)" with tomorrow$/) do |field|
  fill_in(field, :with => Date.today+1)
end

Given(/^event named "(.*?)" already exists$/) do |event_name|
  e = Event.new
  e.name = event_name
  e.date = Date.today+1
  e.account = Account.first
  e.save
end

Given(/^event named "(.*?)" with tag "(.*?)" exists$/) do |event_name, tag|
  e = Event.new
  e.name = event_name
  e.date = Date.today
  e.max = 10
  e.account = Account.first
  e.tag = tag
  e.save
end

Given(/^event named "(.*?)" with date today$/) do |event_name|
  e = Event.new
  e.name = event_name
  e.date = Date.today
  e.max = 10
  e.account = Account.first
  e.save
end

Given(/^event named "(.*?)" with date today and (\d+) members$/) do |event_name, members|
  e = Event.new
  e.name = event_name
  e.date = Date.today
  e.max = members
  e.account = Account.first
  e.save
end

Given(/^event named "(.*?)" with date tomorrow$/) do |event_name|
  e = Event.new
  e.name = event_name
  e.max = 10
  e.date = Date.today+1
  e.account = Account.first
  e.save
end

Given /^there are not events$/ do
  Rating.all.destroy
  Event.all.destroy
end

Given /^I want to rate "([^"]*)"$/ do | event_name |
  event = Event.find_by_name(event_name)
  visit "/events/rate/#{event.slug}"
end

When /^I fill in "([^"]*)" with yesterday$/ do |field|
  fill_in(field, :with => Date.today-1)
end

When /^I fill in "([^"]*)" with today$/ do |field|
  fill_in(field, :with => Date.today)
end

Given /^I am logged in$/ do
  visit "/login"
  fill_in("name", :with => "cucumber_user")
  fill_in("email", :with => "cucumber_user@someplace.com")
  click_button "submit"
end

Given /^I am logged out$/ do
  visit "/logout"
end

When(/^I wait a while$/) do
  sleep(2)
end

Given(/^the event named "(.*?)" and rated with (\d+)$/) do |event_name, rate|
  e = Event.new
  e.name = event_name
  e.date = Date.today + 1
  e.account = Account.first
  e.save
  r = Rating.for_event(e)
  r.value = rate
  r.save
end

Given(/^the event named "(.*?)" and rated with (\d+) , (\d+) times$/) do |event_name, rate, cant|
  e = Event.new
  e.name = event_name
  e.date = Date.today + 1
  e.account = Account.first
  e.save
  num = cant.to_i

  num.times do
    r = Rating.for_event(e)
    r.value = rate
    r.save
    e.ratings.push(r)
  end
end

Given(/^the event named "(.*?)" and rated with (\d+) , (\d+) and "(.*?)"$/) do |event_name, rate1, rate2, rate3|
  e = Event.new
  e.name = event_name
  e.date = Date.today + 1
  e.account = Account.first
  e.save
  
  r = Rating.for_event(e)
  r.value = rate1
  r.save
  e.ratings.push(r)

  r = Rating.for_event(e)
  r.value = rate2
  r.save
  e.ratings.push(r)

  r = Rating.for_event(e)
  r.value = rate3
  r.save
  e.ratings.push(r)
end

Given(/^I add the member "(.*?)"$/) do |member|
  miembros =  find_field("event[members]").value + ", " + member
  fill_in("event[members]", :with => miembros)
end

Given(/^I remove the member "(.*?)"$/) do |member|  
  miembros =  find_field("event[members]").value
  miembros.slice! member
  fill_in("event[members]", :with => miembros)
end

Given(/^I am browsing the ratings page for event with slug "(.*?)"$/) do |event_slug|
  visit "/events/#{event_slug}/ratings"
end

Given(/^I am browsing the edit page for event with slug "(.*?)"$/) do |event_slug|
  visit "/events/#{event_slug}/edit"
end

Given(/^I am browsing the comparation page for event with tag "(.*?)"$/) do |event_tag|
  visit "/events/#{event_tag}/comparation"
end
