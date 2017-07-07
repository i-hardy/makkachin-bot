require "discordrb"

class SprintTimer
  attr_reader :startin, :length
  attr_accessor :users

  # Initialize with the values parsed by Makkachin for start time and length of timer
  def initialize(startin, length)
    @startin = startin
    @length = length
    @users = []
  end

  def set_start
    "Get ready to sprint in #{startin} #{minutes_plural}"
    sleep (startin * 60)
    sprint_starter
  end

  def sprint_starter
    "@#{users.join(", @")} #{length} minute sprint starts now!"
    sprint
  end

  def sprint
    sleep (length * 60)
    sprint_ender
  end

  def sprint_ender

  end

  def get_users_sprinting(user)
    users << user
  end

  def minutes_plural
    if startin == 1
      "minute"
    else
      "minutes"
    end
  end

end
