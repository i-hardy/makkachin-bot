require "discordrb"
require_relative "makkamethods"

# This creates a timer object for a 'writing sprint', in which users attempt to
# write as much as possible in a given time.

class SprintTimer
  attr_reader :ended

  def initialize(startin, length, event)
    @startin = startin
    @length = length
    @event = event
    @ended = false
  end

  def set_start
    event.respond "Get ready to sprint in #{startin} #{minutes_plural}"
    sleep 60 * startin
    sprint_starter
  end

  def sprint_starter
    event.respond "#{makkachin.userlist.user_mentions} #{length} minute sprint starts now!"
    sprint
  end

  def sprint_ender
    event.respond "#{makkachin.userlist.user_mentions} Stop sprinting!"
    @ended = true
  end

  private

  attr_reader :startin, :length, :event, :users

  def sprint
    sleep 60 * length
    sprint_ender
  end

  def minutes_plural
    startin == 1 ? "minute" : "minutes"
  end

end
