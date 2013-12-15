require './lib/gol.rb'

cells = [[-3, -3], [-3, -4], [-4, -4], [-4, -3], [1,1], [1,2], [1,3], [0,3], [-1,2]]
gol = GameOfLife.new(cells)

(1..50).each do
  gol.tick()
  puts gol.to_s
  puts " ----------- "
  sleep 0.5
end
