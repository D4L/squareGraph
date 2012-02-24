require 'face.rb'

class SquareGraph

  attr_reader :length, :width

  def initialize(*dimen)
    raise ArgumentError, "Only zero or two parameters" if ![0,2].include?(dimen.size)
    if dimen.size == 2
      raise ArgumentError if dimen[0].class != Fixnum or dimen[1].class != Fixnum
      raise ArgumentError if dimen[0] < 1 or dimen[1] < 1
      @length, @width = dimen[0], dimen[1]
      @sized = true
    else
      @sized = false
    end
    @sg = Hash.new
  end

  def resize(length, width)
    raise NoMethodError if @sized == false
    raise ArgumentError if length.class != Fixnum or width.class != Fixnum
    raise ArgumentError if length < 1 or width < 1
    @length, @width = length, width
  end

  def fill(*args)
    x, y = args[0], args[1]
    @sg[[x,y]] = Face.new(x, y, true)
  end

  def get(x, y)
    @sg[[x,y]].object
  end

  def insert
  end

  def get_truthy(x, y)
  end
end
