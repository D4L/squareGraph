require 'face'

class SquareGraph

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

  def resize(length, width)
    raise NoMethodError if @sized == false
    test_fixnum(length, width)
    return nil if test_range([1, length], [1, width])
    if !@sg.empty?
      return nil if test_range([@sg.keys.max_by {|x| x[0]} [0], length], [@sg.keys.max_by {|y| y[1]} [1], width])
    end
    @length, @width = length, width
  end

  def fill(*args)
    x, y = args[0], args[1]
    test_fixnum(x, y)
    if @sized == true
      return nil if test_range([1, x], [1, y], [x, @length], [y, @length])
    end
    @sg[[x,y]] = Face.new(x, y, true)
  end

  def get(x, y)
    return nil if !@sg[[x,y]]
    @sg[[x,y]].object
  end

  def remove(*args)
    x, y = args[0], args[1]
    test_fixnum(x, y)
    @sg.delete([x, y])
  end

  def clear
    @sg.clear
  end

  def empty?
    !(@sg.any? do |f|
      @sg[f[0]] and @sg[f[0]].object
    end)
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

end
