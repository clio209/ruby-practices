#!/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |s|
  if s == 'X'
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = []
shots.each_slice(2) do |s|
  frames << s
end

# point = 0
point = frames.each_with_index.sum(0) do |frame, i|
  if frame[0] == 10 && i <= 8
    if frames[i.next][0] == 10
      10 + frames[i.next][0] + frames[i + 1.next][0]
    else
      10 + frames[i.next].sum
    end
  elsif frame.sum == 10 && i <= 8
    10 + frames[i.next][0]
  else
    frame.sum
  end
end

p point
