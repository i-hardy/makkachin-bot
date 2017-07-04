require "discordrb"

bot = Discordrb::Bot.new token: 'MzMxNTE0MzgzMTA2NzAzMzcx.DD1pyQ.2OKFDwJgIVdH1uqs3VkBqtgjIOM', client_id: 331514383106703371

stringrex = /!sprint in (\d+) for (\d+)/

bot.mention do |event|
  event.respond "Woof! Here are the things I know how to do: \n
                - To set up a writing sprint for y minutes in x minutes' time, type \"!sprint in x for y\" \n
                - To ask me for my opinion on steamed buns, type \"!buns\""
end

bot.message(contains: stringrex ) do |event|
  start, duration = event.message.content.match(stringrex).captures
  event.respond "Get ready to sprint in #{start} minutes"
  sleep (start.to_i * 60)
  event.respond "@here #{duration} minute sprint starts now!"
  sleep (duration.to_i * 60)
  event.respond "@here Stop sprinting!"
end

bot.message(content: "!buns") do |event|
  event.respond "NOM <:makkabuns:331514484378042368>"
end

bot.run
