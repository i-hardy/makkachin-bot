require "discordrb"
require "giphy"
require_relative "sprint_timer"

module MakkaMethods
  SPRINT_REGEX = /!sprint in (\d+) for (\d+)/

  def commands_list
    "Woof! I'm in testing mode! Here are the things I know how to do: \n
                  - To set up a writing sprint for y minutes in x minutes' time, type \"!sprint in x for y\" \n
                  - To see a cute kitty, type \"!cat\" \n
                  - To ask me for my opinion on steamed buns, type \"!buns\""
  end

  def writing_sprint(event)
    start, duration = event.message.content.match(SPRINT_REGEX).captures
    timer = SprintTimer.new(start.to_i, duration.to_i, event)
    timer.set_start
  end

  def buns
    "NOM <:makkabuns:331514484378042368>"
  end

  def giphy_fetcher(animal)
    "#{Giphy.random(animal).image_url}"
  end
end
