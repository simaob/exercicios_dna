#!/usr/bin/env ruby

require 'byebug'

fasta = "dna.example.fasta"

n = ARGV.shift
n = n.length > 0 ? n.to_i : 5

sequences = []
current = nil
repeats = {}
full_seq = ''
name = nil
File.open(fasta).each do |f|
  if f[0] == ">"
    repeats = []
    if full_seq.length > 0
      i = 0
      j = n-1
      while (substr = full_seq[i..j]) do
        repeat = repeats.select{|t| t[:repeat] == substr }.first
        if repeat
          repeat[:count] += 1
        else
          repeats << {
            repeat: substr,
            count: 1
          }
        end
        i += 1
        j += 1
      end
      sequences << {
        name: name,
        repeats: repeats
      }
      full_seq = ''
    end
    name = f[1, f.length-1]
  else
    full_seq += f.strip
  end
end

sequences.each do |t|
  puts t[:name]
  puts "#{t[:repeats].size} repeats of length #{n}"
  sorted = t[:repeats].sort{|a,b| b[:count] <=> a[:count]}
  puts "most repeat: #{sorted.first[:repeat]} (#{sorted.first[:count]})"
  puts "least repeat: #{sorted.last[:repeat]} (#{sorted.last[:count]})"
  puts "#######################################################################"
end
