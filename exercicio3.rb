#!/usr/bin/env ruby

require 'byebug'
fasta = "dna.example.fasta"

start = "ATG"
stop = ["TAA", "TAG", "TGA"]

sequences = []

current_seq = nil
orf = ''
last_three = ''
started_orf = false

File.open(fasta).each do |f|
  if f[0] == ">"
    current_seq = {
      name: f[1, f.length-1],
      orfs: []
    }
    sequences << current_seq
    orf = ''
    last_three = ''
    started_orf = false
  else
    f.split("").each do |c|
      if last_three.length < 3
        last_three << c
        next
      else
        last_three = last_three[1..-1]
        last_three << c
      end
      if !started_orf && last_three == start
        orf = last_three
        current_seq[:orfs] << orf
        started_orf = true
        next
      elsif started_orf
        orf << c
      end
      if stop.include?(last_three)
        last_three = ''
        started_orf = false
      end
    end
  end
end

sequences.each do |s|
  puts s[:name]
  s[:orfs].each do |o|
    puts "#{o.size} for #{o}"
  end
  puts "###############################################"
end
