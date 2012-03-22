class SquareGraph
  require 'square_graph/face'
  require 'square_graph/simpleutilities'
  require 'square_graph/iterators'
  require 'square_graph/truthy'

  attr_reader :length, :width

  def initialize(*dimen)
    raise ArgumentError if ![0,2].include?(dimen.size)
    if dimen.size == 2
      test_fixnum(dimen[0], dimen[1])
      raise ArgumentError if test_range([1, dimen[0]], [1, dimen[1]])
      @length, @width = dimen[0], dimen[1]
      @sized = true
    else
      @sized = false
    end
    @sg = Hash.new
  end

  def anytrue?
    !(@sg.any? do |f|
      @sg[f[0]] and @sg[f[0]].object
    end)
  end

  def neighbours (loc)
    if loc.class == Face
      loc = Array.new([loc.x, loc.y])
    end
    result = Array.new
    [[1,1],[1,0],[1,-1],[0,-1],[-1,-1],[-1,0],[-1,1],[0,1]].each do |around|
      result.push @sg[[loc[0] + around[0], loc[1] + around[1]]] if @sg[[loc[0] + around[0], loc[1] + around[1]]]
    end
    result
  end

  private

  def test_fixnum(*value)
    value.each do |v|
      raise ArgumentError if v.class != Fixnum
    end
  end

  def test_range(*value)
    value.any? {|pair| pair[0] > pair[1]}
  end

  def comp(pos)
    Proc.new do |x,y|
      if pos == 'x'
        x[0] <=> y[0]
      else
        x[1] <=> y[1]
      end
    end
  end

end
