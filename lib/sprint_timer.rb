require "discordrb"
require_relative "makkamethods"

class SprintTimer
  attr_accessor :users
  include MakkaMethods

  # Initialize with the values parsed by Makkachin for start time and length of timer
  def initialize(startin, length, event)
    @startin = startin
    @length = length
    @event = event
    @users = []
  end

  def set_start
    sprinters_array_init
    load_sprinters
    event.respond "Get ready to sprint in #{startin} #{minutes_plural}"
    sleep 60 * startin
    sprint_starter
  end

  def get_users_sprinting(user)
    users << user
  end

  def sprint_starter
    event.respond "@here #{length} minute sprint starts now!"
    sprint
  end

  def sprint_ender
    event.respond "@here Stop sprinting!"
  end

  private

  attr_reader :startin, :length, :event

  def sprint
    sleep 60 * length
    sprint_ender
  end

  def minutes_plural
    if startin == 1
      "minute"
    else
      "minutes"
    end
  end

end
