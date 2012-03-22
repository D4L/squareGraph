class SquareGraph
  def resize(length, width)
    raise NoMethodError if @sized == false
    test_fixnum(length, width)
    return nil if test_range([1, length], [1, width])
    if !@sg.empty?
      return nil if test_range([@sg.keys.max_by {|x| x[0]} [0], length], [@sg.keys.max_by {|y| y[1]} [1], width])
    end
    @length, @width = length, width
    self
  end

  def fill(x, y, o = true)
    test_fixnum(x, y)
    if not o
      self.remove(x, y) if @sg[[x, y]]
      return nil
    end
    if @sized == true
      return nil if test_range([1, x], [1, y], [x, @length], [y, @length])
    end
    return nil if @sg[[x,y]]
    @sg[[x,y]] = Face.new(x, y, o, self)
  end

  def get(x, y)
    return nil if !@sg[[x,y]]
    @sg[[x,y]].object
  end

  def get_face(x, y)
    return nil if !@sg[[x,y]]
    @sg[[x,y]]
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
    @sg.none?
  end

  def objects
    rt = Array.new
    @sg.values.each do |f|
      rt.push (f.object)
    end
    return nil if rt.size == 0
    rt
  end

  def == sg2
    sg2.each_pos do |p|
      return false if self.get(p[:x], p[:y]) != sg2.get(p[:x], p[:y])
    end
    true
  end
end
