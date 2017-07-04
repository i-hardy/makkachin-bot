require "discordrb"

bot = Discordrb::Bot.new token: 'MzMxNTE0MzgzMTA2NzAzMzcx.DD1pyQ.2OKFDwJgIVdH1uqs3VkBqtgjIOM', client_id: 331514383106703371

stringrex = /!sprint in (\d+) for (\d+)/

bot.mention do |event|
  event.respond "Woof! Here are the things I know how to do: \n
                - To do a ten minute writing sprint in five minutes' time, type \"!sprint in 5 for 10\""
end

bot.message(contains: stringrex ) do |event|
  start, duration = event.message.content.match(stringrex).captures
  min_pl = "minutes" unless start == "1"
  event.respond "Get ready to sprint in #{start} #{min_pl}"
  sleep (start.to_i * 60)
  event.respond "@here #{duration} minute sprint starts now!"
  sleep (duration.to_i * 60)
  event.respond "@here Stop sprinting!"
end

bot.run
