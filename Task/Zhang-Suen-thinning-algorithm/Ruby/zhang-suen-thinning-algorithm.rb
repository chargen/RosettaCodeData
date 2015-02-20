class ZhangSuen
  NEIGHBOUR8 = [[-1,0],[-1,1],[0,1],[1,1],[1,0],[1,-1],[0,-1],[-1,-1]]  # 8 neighbors
  CIRCULARS = NEIGHBOUR8 + [NEIGHBOUR8.first]                       # P2, ... P9, P2
  def initialize(str, black="#")
    s1 = str.each_line.map{|line| line.chomp.each_char.map{|c| c==black ? 1 : 0}}
    s2 = s1.map{|line| line.map{0}}
    xrange = 1 ... s1.size-1
    yrange = 1 ... s1[0].size-1
    printout(s1)
    begin
      @r = 0
      xrange.each{|x| yrange.each{|y| s2[x][y] = s1[x][y] - zs(s1,x,y,1)}}  # Step 1
      xrange.each{|x| yrange.each{|y| s1[x][y] = s2[x][y] - zs(s2,x,y,0)}}  # Step 2
    end until @r == 0
    printout(s1)
  end
  def zs(ng,x,y,g)
    return 0 if ng[x][y] == 0 or                                    # P1
               (ng[x-1][y] + ng[x][y+1] + ng[x+g][y-1+g]) == 3 or   # P2, P4, P6/P8
               (ng[x-1+g][y+g] + ng[x+1][y] + ng[x][y-1]) == 3      # P4/P2, P6, P8
    bp1 = NEIGHBOUR8.inject(0){|res,(i,j)| res += ng[x+i][y+j]}     # B(P1)
    return 0 if bp1 < 2 or 6 < bp1
    ap1 = CIRCULARS.map{|i,j| ng[x+i][y+j]}.each_cons(2).count{|a,b| a<b}   # A(P1)
    return 0 if ap1 != 1
    @r = 1
  end
  def printout(image)
    puts image.map{|row| row.map{|col| " #"[col]}.join}
  end
end

str = <<EOS
...........................................................
.#################...................#############.........
.##################...............################.........
.###################............##################.........
.########.....#######..........###################.........
...######.....#######.........#######.......######.........
...######.....#######........#######.......................
...#################.........#######.......................
...################..........#######.......................
...#################.........#######.......................
...######.....#######........#######.......................
...######.....#######........#######.......................
...######.....#######.........#######.......######.........
.########.....#######..........###################.........
.########.....#######.######....##################.######..
.########.....#######.######......################.######..
.########.....#######.######.........#############.######..
...........................................................
EOS

ZhangSuen.new(str)

task_example = <<EOS
00000000000000000000000000000000
01111111110000000111111110000000
01110001111000001111001111000000
01110000111000001110000111000000
01110001111000001110000000000000
01111111110000001110000000000000
01110111100000001110000111000000
01110011110011101111001111011100
01110001111011100111111110011100
00000000000000000000000000000000
EOS

ZhangSuen.new(task_example, "1")
