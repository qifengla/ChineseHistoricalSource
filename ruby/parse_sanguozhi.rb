# frozen_string_literal: true

require 'json'
require_relative './util.rb'

counter = 0
# the first chapter has some encoding problem, have to hack it
chapter = nil
json_array = []
File.open('utf8/三国志乱序版.txt', 'r') do |utf8_input|
  utf8_input.each_line do |line|
    # Check if it is a new chapter
    new_chapter = line[/三国志 - (.*)第.* - 中国古典文学/, 1]
    if new_chapter
      chapter = new_chapter.strip
      puts "Processing chapter #{chapter}"
      counter += 1
      next
    end

    # Process each chapter
    line.split.each do |paragraph|
      # puts "Dumping: #{paragraph}"
      json_array << generate_paragraph_json('三国志', chapter, paragraph)
    end
    counter += 1

    # break if counter > 10
  end

  # puts json_array
  File.open('json/sanguozhi.json', 'w') do |json_output|
    json_output.write(JSON.pretty_generate(json_array))
  end
end
