require 'date'

class Counter
  SCHEDULE = "#{File.dirname(__FILE__)}/schedule.txt"

  def self.countdown
    file = File.open(SCHEDULE, "r")
    file_data = file.readlines.map(&:chomp)
    file.close

    today = Date.today
    file_data.each do |d|
      task, deadline = d.split("->").map { |s| s.strip }
      deadline = Date.parse(deadline)
      day_remain = (deadline - today).to_i
      puts "#{task} in #{day_remain} days"
    end
  end

  def self.add_task
    print "Enter new task: "
    new_task = $stdin.gets.chomp
    print "Enter the deadline (yyyy-mm-dd): "
    deadline = $stdin.gets.chomp

    file = File.open(SCHEDULE, "a")
    file.puts new_task + " -> " + deadline 
    file.close
  end
end
