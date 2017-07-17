require "discordrb"
require "giphy"
require "yaml"
require_relative "sprint_timer"
require_relative "makkamethods"

Giphy::Configuration.configure do |config|
  config.version = "v1"
  config.api_key = "dc6zaTOxFJmzC"
end

DISCORD_CONFIG = YAML.load_file("config.yaml")

makkachin = Discordrb::Bot.new token: DISCORD_CONFIG["token"],
client_id: DISCORD_CONFIG["client_id"]

extend MakkaMethods

makkachin.ready do |startup|
  role_creator(makkachin.servers.shift.pop) unless makkachin.role_finder.any? { |role| role.name == DISCORD_CONFIG["sprinting_role"] }
  role_getter(makkachin.role_finder.find { |role| role.name == DISCORD_CONFIG["sprinting_role"] })
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
