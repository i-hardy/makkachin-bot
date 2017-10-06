require "discordrb"
require "giphy"
require "yaml"
require_relative "sprint_timer"
require_relative "userlist"

module MakkaMethods
  DISCORD_CONFIG = YAML.load_file("config.yaml")
  SPRINT_REGEX = /!sprint in (\d+) for (\d+)/

  def commands_list
    "Woof! Here are the things I know how to do: \n
                  - To set up a writing sprint for y minutes in x minutes' time, type \"!sprint in x for y\"\n
                  - To opt-in to a sprint that's running, type \"!sprinting\" \n
                  - To be notified of every sprint, type \"!stamina\" \n
                  - To stop being notified of every sprint, type \"!tired\" \n
                  - To see a cute cat or dog, type \"!cat\" or \"!dog\" \n
                  - To ask me for my opinion on steamed buns, type \"!buns\" \n
                  - To see a picture of my friend Potya, type \"!potya\""
  end

  def role_finder(bot)
    bot.servers.first.last.roles
  end

  def role_creator(bot)
    bot.servers.first.last.create_role(name: DISCORD_CONFIG["sprinting_role"], colour: 7506394, mentionable: true)
  end

  def role_getter(role)
    @sprinting_role = role
  end

  def writing_sprint(event)
    raise "One sprint at a time!" unless timer.nil? || timer.ended?
    sprint_init(event)
    timer.set_start
  end

  def get_sprinters(event)
    raise "No sprint is running" if timer.nil? || timer.ended?
    timer.userlist.get_users_sprinting(event.author)
  end

  def permasprinters(sprinter)
    sprinter.add_role(sprinting_role)
  end

  def tired_sprinters(sprinter)
    sprinter.remove_role(sprinting_role)
  end

  def buns
    "NOM #{DISCORD_CONFIG["makka_emoji"]}"
  end

  def giphy_fetcher(animal)
    "#{Giphy.random(animal).image_url}"
  end

  def sprint_init(event)
    start, duration = event.message.content.match(SPRINT_REGEX).captures
    @timer = SprintTimer.new(start.to_i, duration.to_i, event)
    timer.userlist.get_users_sprinting(sprinting_role)
  end

private
  attr_reader :timer, :sprinting_role

end
