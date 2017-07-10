require "discordrb"
require "giphy"
require "csv"
require_relative "sprint_timer"

module MakkaMethods
  attr_reader :sprinting_role

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
    p sprinting_role
  end

  def writing_sprint(event)
    fail "One sprint at a time!" unless timer.nil? || timer.ended
    start, duration = event.message.content.match(SPRINT_REGEX).captures
    @timer = SprintTimer.new(start.to_i, duration.to_i, event)
    timer.role_setter(sprinting_role)
    timer.set_start
  end

  def get_sprinters(event)
    fail "No sprint is running" if timer.ended
    timer.get_users_sprinting(event.author)
  end

  def permasprinters(sprinter)
  #  fail "User's stamina is already impressive" if sprinter.role?(sprinting_role)
    sprinter.add_role(sprinting_role)
  end

  def tired_sprinters(sprinter)
  #  fail "User is already tired" unless sprinter.role?(sprinting_role)
    sprinter.remove_role(sprinting_role)
  end

  def buns
    "NOM <:makkabuns:331514484378042368>"
  end

  def giphy_fetcher(animal)
    "#{Giphy.random(animal).image_url}"
  end

private
  attr_reader :timer

end
