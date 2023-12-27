require_relative "rimi-counter/rimi-counter.rb"

util, option = ARGV

if util == "counter"
  if option == nil or option == "-l"
    Counter.countdown
  elsif option == "-a"
    Counter.add_task
  end
end

