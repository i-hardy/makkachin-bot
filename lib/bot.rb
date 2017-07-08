require_relative "makkamethods"

class Bot
  extend MakkaMethods

  def timer_end
    @timer = nil
  end
end
