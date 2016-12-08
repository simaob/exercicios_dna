#!/usr/bin/env ruby

require 'byebug'

def count_records
  fasta = "dna.example.fasta"

  count = 0
  lines = 0
  no_new_record_line = 0

  File.open(fasta).each do |f|
    if f[0] == ">"
      count += 1
    else
      no_new_record_line += 1
    end
    lines += 1
  end

  puts "I saw #{count} records"
  puts "Other stats: #{lines} total lines ; #{no_new_record_line} non new record"
  count
end

puts count_records
