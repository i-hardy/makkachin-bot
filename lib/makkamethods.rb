require "discordrb"
require "giphy"
require "csv"
require_relative "sprint_timer"

module MakkaMethods
  attr_accessor :timer, :sprinters_array

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

  def writing_sprint(event)
    fail "One sprint at a time!" if !timer.ended
    start, duration = event.message.content.match(SPRINT_REGEX).captures
    @timer = SprintTimer.new(start.to_i, duration.to_i, event)
    timer.set_start
  end

  def get_sprinters(event)
    fail "No sprint is running" if timer.ended
    timer.get_users_sprinting(event.author.discriminator)
  end

  def sprinters_array_init
    @sprinters_array = []
  end

  def permasprinters(sprinter)
    fail "User's stamina is already impressive" if CSV.read("permasprinters.csv").flatten.include?(sprinter)
    sprinters_array_init
    load_sprinters
    sprinters_array << sprinter
    save_sprinters_array
  end

  def tired_sprinters(sprinter)
    fail "User is already tired" if !CSV.read("permasprinters.csv").flatten.include?(sprinter)
    sprinters_array_init
    load_sprinters
    sprinters_array.delete_if { |user| user == sprinter }
    save_sprinters_array
  end

  def buns
    "NOM <:makkabuns:331514484378042368>"
  end

  def giphy_fetcher(animal)
    "#{Giphy.random(animal).image_url}"
  end

private

  def load_sprinters
    CSV.foreach("permasprinters.csv", headers: true) do |row|
      create_sprinters_array(row["username"])
    end
  end

  def create_sprinters_array(userid)
    sprinters_array << userid
  end

  def save_sprinters_array
    CSV.open("permasprinters.csv", "w",
    :write_headers=> true,
    :headers => ["username"]
    ) do |csv|
      csv.truncate(0)
      sprinters_array.each do |sprinter|
        csv << [sprinter]
      end
    end
  end
end
