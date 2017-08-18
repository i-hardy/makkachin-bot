require "discordrb"
require "giphy"
require "yaml"
require_relative "makkamethods"

Giphy::Configuration.configure do |config|
  config.version = "v1"
  config.api_key = "dc6zaTOxFJmzC"
end

class Makkachin
  # Uncomment these lines to use YAML config
  # makkachin = Discordrb::Bot.new token: MakkaMethods::DISCORD_CONFIG["token"],
  # client_id: MakkaMethods::DISCORD_CONFIG["client_id"]

  # Comment out the next two lines to use YAML config
  makkachin = Discordrb::Bot.new token: ENV["MAKKACHIN_BOT_TOKEN"],
  client_id: ENV["MAKKACHIN_CLIENT_ID"]

  extend MakkaMethods

  makkachin.ready do |startup|
    role_creator(makkachin) unless role_finder(makkachin).any? { |role| role.name == MakkaMethods::DISCORD_CONFIG["sprinting_role"] }
    role_getter(role_finder(makkachin).find { |role| role.name == MakkaMethods::DISCORD_CONFIG["sprinting_role"] })
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
    animal = event.message.content.match(/(cat)|(dog)/).captures
    event.respond giphy_fetcher(animal.find { |item| !item.nil?  })
  end

  makkachin.message(contains: "!potya") do |event|
    event.respond giphy_fetcher(nil)
  end

  makkachin.run
end
