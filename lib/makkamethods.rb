require "discordrb"
require "giphy"
require_relative "sprint_timer"
require_relative "userlist"

module MakkaMethods
  SPRINT_REGEX = /!sprint in (\d+) for (\d+)/

  def commands_list
    "Woof! Here are the things I know how to do: \n
                  - To set up a writing sprint for y minutes in x minutes' time, type \"!sprint in x for y\"\n
                  - To opt-in to a sprint that's running, type \"!sprinting\" \n
                  - To be notified of every sprint, type \"!stamina\" \n
                  - To stop being notified of every sprint, type \"!tired\" \n
                  - To see a cute cat or dog, type \"!cat\" or \"!dog\" \n
                  - To ask me for my opinion on steamed buns, type \"!buns\""
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
    "NOM <:makkabuns:331514484378042368>"
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

=begin  def sprint_init(event)
    start, duration = event.message.content.match(SPRINT_REGEX).captures
    @timer = SprintTimer.new(start.to_i, duration.to_i, event)
    timer.userlist.get_users_sprinting(sprinting_role)
=end
end
