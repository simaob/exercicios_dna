#!/usr/bin/env ruby

require 'byebug'

fasta = "dna.example.fasta"

sequences = []
# [{
# name: "sequence_name",
# length: "sequence_length"
# }]

name = nil
count = 0

#File.open(fasta).each do |f|
#  if f[0] == ">"
#    if name
#      sequences << {
#        name: name,
#        count: count
#      }
#    end
#    name = f[1,f.length-1]
#    count = 0
#  else
#    count += f.length
#  end
#end

current_seq = nil
File.open(fasta).each do |f|
  if f[0] == ">"
    current_seq = {
      name: f[1,f.length-1],
      count: 0
    }
    sequences << current_seq
  else
    current_seq[:count] = current_seq[:count] + f.length
  end
end

sequences.each do |s|
  puts "#{s[:name]}: #{s[:count]} length"
end
sequences.sort!{|a,b| a[:count] <=> b[:count]}

longest = sequences.last
shortest = sequences.first

puts "longest sequence: #{longest[:name]} with #{longest[:count]}"
puts "shortest sequence: #{shortest[:name]} with #{shortest[:count]}"

puts "Only shortest? #{shortest[:count] != sequences[1][:count]}"
puts "Only longest? #{longest[:count] != sequences[sequences.length-2][:count]}"
