require "discordrb"

bot = Discordrb::Bot.new token: 'MzMxNTE0MzgzMTA2NzAzMzcx.DDwqiw.xKNt_ExmtF0s34vwLe08A8SF1DI', client_id: 331514383106703371

stringrex = /!sprint in (\d+) for (\d+)/

bot.mention do |event|
  event.respond "Woof! Here are my commands: \n
                - To do a ten minute writing sprint in five minutes' time, type \"!sprint in 5 for 10\""
end

bot.message(contains: stringrex ) do |event|
  start, duration = event.message.content.match(stringrex).captures
  event.respond "Sprint timer set!"
  sleep (start.to_i * 60)
  event.respond "@here #{duration} minute sprint starts now!"
  sleep (duration.to_i * 60)
  event.respond "@here Stop sprinting!"
end

bot.run
