class GameOfLife
  @cells=[]
  def initialize(starting_cells=nil)
    @cells = starting_cells
  end

  def cells
    @cells
  end

  def top_left_bottom_right
    xs = @cells.map {|c| c[0]} .sort
    ys = @cells.map {|c| c[1]} .sort
    return [xs.first - 1, ys.first - 1], [xs.last + 1, ys.last + 1]
  end

  # count our number of alive neighbors
  def count_neighbors(cell)
    count_coord_neighbors(cell[0], cell[1])
  end

  def count_coord_neighbors(x,y)
    neighbors = 0
    potential_neighbors(x,y).each do |c|
      neighbors +=1 if currently_alive?([c[0],c[1]])
    end
    neighbors
  end

  # get the coordinates for this cell's neighbors
  def cells_neighbors(cell)
    potential_neighbors(cell[0], cell[1])
  end

  def potential_neighbors(x,y)
    c = []
    (x-1..x+1).each do |potential_x|
      (y-1..y+1).each do |potential_y|
        c << [potential_x, potential_y]
      end
    end
    c.delete([x,y])
    c
  end

  # check to see if this cell is currently alive
  def currently_alive?(cell)
    @cells.include? cell
  end

  # check to see if a cell should live into the next round
  def should_live?(cell)
    neighbors = count_neighbors(cell)
    case neighbors
    when 2
      return currently_alive?(cell)
    when 3
      return true
    end
    false
  end

  # tick to the next round
  def tick
    next_round = []
    find_potential_cells.each do |c|
      next_round << c if should_live?(c)
    end
    @cells = next_round.uniq
  end

  # we only need to check cells adjacent to living cells and currently living cells
  def find_potential_cells
    cells_to_check = Array.new(@cells)
    @cells.each do |c|
      neighbors = cells_neighbors c
      neighbors.each do |n|
        cells_to_check << n
      end
    end
    cells_to_check.uniq
  end

  # print out our board
  def to_s
    str = ""
    top_left, bottom_right = top_left_bottom_right
    (top_left[0]..bottom_right[0]).each do |x|
      str << '|'
      (top_left[1]..bottom_right[1]).each do |y|
        str << (currently_alive?([x,y]) ? 'X' : ' ') + "|"
      end
      str << "\n"
    end
    str
  end

end
