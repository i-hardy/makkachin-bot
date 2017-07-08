require "discordrb"
require "giphy"
require "csv"
require_relative "sprint_timer"

module MakkaMethods
  attr_accessor :timer

  SPRINT_REGEX = /!sprint in (\d+) for (\d+)/

  def commands_list
    "Woof! Here are the things I know how to do: \n
                  - To set up a writing sprint for y minutes in x minutes' time, type \"!sprint in x for y\" \n
                  - To opt-in to a sprint that's running, type \"!sprinting\"
                  - To be notified of every sprint, type \"!stamina\"
                  - To stop being notified of every sprint, type \"!shush\"
                  - To see a cute cat or dog, type \"!cat\" or \"!dog\" \n
                  - To ask me for my opinion on steamed buns, type \"!buns\""
  end

  def writing_sprint(event)
    fail "One sprint at a time!" if timer
    start, duration = event.message.content.match(SPRINT_REGEX).captures
    @timer = SprintTimer.new(start.to_i, duration.to_i, event)
    timer.set_start
  end

  def get_sprinters(event)
    fail "No sprint is running" if !timer
    timer.get_users_sprinting(event.author.username)
  end

  def permasprinters(sprinter)
    fail "User's stamina is already impressive" if CSV.read("permasprinters.csv").flatten.include?(sprinter)
    CSV.open("permasprinters.csv", "w") do |csv|
      csv << (CSV::Row.new(["user"], [sprinter]))
    end
  end

  def tired_sprinters(sprinter)
    fail "User is already tired" if !CSV.read("permasprinters.csv").flatten.include?(sprinter)
    CSV.foreach("permasprinters.csv", "r+") do |row|
      row.delete_if { |user| user == sprinter }
      CSV.open("permasprinters.csv", "w") do |csv|
        csv << row
      end
    end
  end

  def buns
    "NOM <:makkabuns:331514484378042368>"
  end

  def giphy_fetcher(animal)
    "#{Giphy.random(animal).image_url}"
  end
end
