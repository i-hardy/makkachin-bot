require "discordrb"
require "giphy"
require_relative "sprint_timer"
require_relative "makkamethods"

Giphy::Configuration.configure do |config|
  config.version = "v1"
  config.api_key = "dc6zaTOxFJmzC"
end

extend MakkaMethods

makkachin = Discordrb::Bot.new token: 'MzMyOTc0NjQyMTgyNzUwMjA4.DEF6Ug.1aYzWtb77-BvtNdXNwFyfWlCve0', client_id: 332974642182750208

makkachin.mention do |event|
  event.respond commands_list
end

makkachin.message(contains: MakkaMethods::SPRINT_REGEX ) do |event|
  writing_sprint(event)
end

makkachin.message(contains: "!buns") do |event|
  event.respond buns
end

makkachin.message(contains: ["!cat", "!dog"]) do |event|
  animal = event.message.content.match(/!([a-zA-Z]{3})/).captures
  event.respond giphy_fetcher(animal.pop)
end

makkachin.run
