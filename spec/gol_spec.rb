require 'rspec'
require './lib/gol.rb'

describe GameOfLife do
  it "should store starting cells" do
    gol = GameOfLife.new([[0,1]])
    gol.cells.should_not be_nil
  end

  it "should calculate a set of cells to iterate through" do
    gol = GameOfLife.new([[1,1]])
    gol.top_left_bottom_right.should eq([[0,0],[2,2]])
  end

  it "should be able to count a cell's neighbors" do
    cells = [[1,1], [1,2]]
    gol = GameOfLife.new(cells)
    gol.count_neighbors(cells.first).should eq(1)
  end

  it "should know if a cell is currently alive" do
    gol = GameOfLife.new([[1,1]])
    gol.currently_alive?(gol.cells.first).should eq(true)
  end

  it "should be able to calculate if a cell lives in the next round" do
    gol = GameOfLife.new([[1,1]])
    gol.should_live?(gol.cells.first).should eq(false)
  end

  it "should be able to count cell neighbors" do
    gol = GameOfLife.new([[1,1]])
    gol.cells_neighbors(gol.cells.first).count.should eq(8)
  end

  it "should be able to calculate the next round" do
    gol = GameOfLife.new([[1,1]])
    gol.tick()
  end

  it "should have a different set of cells after each iteration" do
    cells = [[1,1], [1,2], [1,3]]
    gol = GameOfLife.new(cells)
    gol.tick()
    gol.cells.should_not eq(cells)
  end

  it "should correctly run a blinker" do
    cells = [[1,1], [1,2], [1,3]]
    gol = GameOfLife.new(cells)
    gol.tick()
    gol.tick()
    gol.cells.sort.should eq(cells)
  end

  it "should correctly print out the current board" do
    cells = [[1,1], [1,2], [1,3]]
    gol = GameOfLife.new(cells)
    gol.to_s.should eq("| | | | | |\n| |X|X|X| |\n| | | | | |\n")
  end

  it "should correctly run a toad" do
    cells = [[1,1], [1,2], [1,3], [2,2], [2,3], [2,4]]
    gol = GameOfLife.new(cells)
    gol.tick()
    gol.tick()
    gol.cells.sort.should eq(cells)
  end

  it "should glide corrently" do
    cells = [[1,1], [1,2], [1,3], [0,3], [-1,2]]
    gol = GameOfLife.new(cells)
    gol.tick()
    gol.tick()
    gol.tick()
    gol.tick()
    gol.to_s.should eq("| | | | | |\n| | |X| | |\n| | | |X| |\n| |X|X|X| |\n| | | | | |\n")
  end

end
