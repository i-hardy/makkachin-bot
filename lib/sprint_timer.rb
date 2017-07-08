require "discordrb"

class SprintTimer
  attr_accessor :users

  # Initialize with the values parsed by Makkachin for start time and length of timer
  def initialize(startin, length, event)
    @startin = startin
    @length = length
    @users = []
    @event = event
  end

  def set_start
    event.respond "Get ready to sprint in #{startin} #{minutes_plural}"
    sleep 60 * startin
    p "I got here"
    sprint_starter
  end

  def get_users_sprinting(user)
    users << user
  end

  def sprint_starter
    p "And here"
    event.respond "@#{users.join(", @")} #{length} minute sprint starts now!"
    sprint
  end

  def sprint_ender
    p "And here too"
    event.respond "@#{users.join(", @")} Stop sprinting!"
  end

  private

  attr_reader :startin, :length, :event

  def sprint
    sleep (length * 60)
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
