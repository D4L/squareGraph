class SquareGraph

  attr_reader :length, :width

  def initialize(*dimen)
    raise ArgumentError, "Only zero or two parameters" if ![0,2].include?(dimen.size)
    if dimen.size == 2
      raise ArgumentError if dimen[0].class != Fixnum or dimen[1].class != Fixnum
      raise ArgumentError if dimen[0] < 1 or dimen[1] < 1
      @length = dimen[0]
      @width = dimen[1]
      @sized = true
    else
      @sized = false
    end
  end

  def resize(length, width)
    raise NoMethodError if @sized == false
    raise ArgumentError if length.class != Fixnum or width.class != Fixnum
    raise ArgumentError if length < 1 or width < 1
    @length = length
    @width = width
  end
end
