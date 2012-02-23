class SquareGraph
  attr_accessor :length, :width
  def initialize(*dimen)
    raise ArgumentError, "Only zero or two parameters" if ![0,2].include?(dimen.size)
    if dimen.size == 2
      raise ArgumentError if dimen[0].class != Fixnum or dimen[1].class != Fixnum
      @length = dimen[0]
      @width = dimen[1]
    end
  end
end
