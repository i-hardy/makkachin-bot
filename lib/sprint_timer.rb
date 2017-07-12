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
    @users = []
    @ended = false
  end

  def role_setter(role)
    @run_forest_run = role
  end

  def set_start
    event.respond "Get ready to sprint in #{startin} #{minutes_plural}"
    sleep 60 * startin
    sprint_starter
  end

  def get_users_sprinting(user)
    users << user
  end

  def sprint_starter
    if users.empty?
      event.respond "#{run_forest_run.mention} #{length} minute sprint starts now!"
    else
      event.respond "#{run_forest_run.mention} #{users.map{ |user| user.mention }.join(" ")} #{length} minute sprint starts now!"
    end
    sprint
  end

  def sprint_ender
    if users.empty?
      event.respond "#{run_forest_run.mention} Stop sprinting!"
    else
      event.respond "#{run_forest_run.mention} #{users.map{ |user| user.mention }.join(" ")} Stop sprinting!"
    end
    @ended = true
  end

  private

  attr_reader :startin, :length, :event, :users, :run_forest_run

  def sprint
    sleep 60 * length
    sprint_ender
  end

  def minutes_plural
    startin == 1 ? "minute" : "minutes"
  end

end
