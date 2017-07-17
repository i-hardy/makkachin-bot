require "discordrb"

class Userlist
  attr_reader :list

  def initialize
    @list = Array.new
  end

  def get_users_sprinting(user)
    list << user
  end

  def user_mentions
    list.map{ |user| user.mention }.join(" ")
  end
end
