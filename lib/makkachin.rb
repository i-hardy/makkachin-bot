require "discordrb"
require "giphy"
require_relative "sprint_timer"
require_relative "makkamethods"
require_relative "bot"

Giphy::Configuration.configure do |config|
  config.version = "v1"
  config.api_key = "dc6zaTOxFJmzC"
end

makkachin = Discordrb::Bot.new token: 'MzMxNTE0MzgzMTA2NzAzMzcx.DEV43A.BEBzbR-Fv_5D5LjFFOwtL_IcVOk',
client_id: 331514383106703371

extend MakkaMethods

makkachin.ready do |startup|
  role_getter(makkachin.servers.shift.pop.roles.find { |role| role.name == "run forest run" })
end

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
  permasprinters(event.author)
  event.respond "Woof! Your stamina is impressive!"
end

makkachin.message(contains: "!tired") do |event|
  tired_sprinters(event.author)
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
