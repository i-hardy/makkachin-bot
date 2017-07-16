require_relative "sprint_timer"

class Userlist
  attr_reader :list

  def initialize(role)
    @list = Array.new
    list << role
  end

  def get_users_sprinting(user)
    list << user
  end

  def user_mentions
    users.map{ |user| user.mention }.join(" ")
  end
end
