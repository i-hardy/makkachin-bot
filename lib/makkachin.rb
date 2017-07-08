require "discordrb"
require "giphy"
require_relative "sprint_timer"
require_relative "makkamethods"

extend MakkaMethods

Giphy::Configuration.configure do |config|
  config.version = "v1"
  config.api_key = "dc6zaTOxFJmzC"
end

makkachin = Discordrb::Bot.new token: 'MzMxNTE0MzgzMTA2NzAzMzcx.DELwtg.ECT3XhEfpxOFxe14C15Xd_wNhy4', client_id: 331514383106703371

makkachin.mention do |event|
  event.respond commands_list
end

makkachin.message(contains: MakkaMethods::SPRINT_REGEX ) do |event|
  writing_sprint(event)
end

makkachin.message(contains: "!sprinting") do |event|
  get_sprinters(event)
end

makkachin.message(contains: "!stamina") do |event|
  permasprinters(event.author.username)
  event.respond "Woof! Your stamina is impressive!"
end

makkachin.message(contains: "!tired") do |event|
  tired_sprinters(event.author.username)
  event.respond "Woof! You seem tired"
end

makkachin.message(contains: "!buns") do |event|
  event.respond buns
end

makkachin.message(contains: ["!cat", "!dog"]) do |event|
  animal = event.message.content.match(/!(cat)|!(dog)/).captures
  event.respond giphy_fetcher(animal.pop)
end

makkachin.run
