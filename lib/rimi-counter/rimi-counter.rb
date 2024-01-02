require 'date'

module Counter
  SCHEDULE = "#{File.dirname(__FILE__)}/schedule.txt"

  def self.countdown
    today = Date.today
    file_data = File.readlines(SCHEDULE)

    file_data.each_with_index do |line, index|
      task, deadline = line.split("->").map { |s| s.strip }
      deadline = Date.parse(deadline)
      day_remain = (deadline - today).to_i
      puts "[#{index + 1}] #{task} in #{day_remain} days"
    end
  end

  def self.add_task
    print "Enter new task: "
    task = $stdin.gets.chomp

    print "Enter the deadline (yyyy-mm-dd): "
    deadline = $stdin.gets.chomp

    new_line = "#{task} -> #{deadline}"

    file = File.open(SCHEDULE, "a")
    file.puts new_line
    file.close

    puts "[Done] added \"#{new_line}\""
  end

  def self.show_all
    File.open(SCHEDULE, "r").each_with_index do |line, index|
      puts "[#{index + 1}] #{line}"
    end
  end

  def self.edit
    file_data = File.readlines(SCHEDULE)
    file_data.each_with_index do |line, index|
      puts "[#{index + 1}] #{line}"
    end

    print "\nEnter the line to edit: "
    line = $stdin.gets.chomp.to_i

    print "Enter new task: "
    task = $stdin.gets.chomp

    print "Enter the deadline (yyyy-mm-dd): "
    deadline = $stdin.gets.chomp

    deleted_line = file_data[line - 1].chomp
    new_line = "#{task} -> #{deadline}"
    file_data[line - 1] = new_line

    File.open(SCHEDULE, "w") do |file|
      file.puts file_data
    end

    puts "[Done] changed \"#{deleted_line}\" to \"#{new_line}\""
  end

  def self.delete
    file_data = File.readlines(SCHEDULE)
    file_data.each_with_index do |line, index|
      puts "[#{index + 1}] #{line}"
    end

    print "\nEnter the line to delete (c to cancel): "
    line = $stdin.gets.chomp

    if line == "c"
      exit
    end

    line = line.to_i
    deleted_line = file_data[line - 1].chomp
    file_data.delete_at(line - 1)

    File.open(SCHEDULE, "w") do |file|
      file.puts file_data
    end

    puts "[Done] deleted \"#{deleted_line}\""
  end
end
