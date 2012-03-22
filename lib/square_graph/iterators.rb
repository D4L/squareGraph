class SquareGraph
  def each
    return nil if @sg.empty?
    @sg.each_pair do |p, f|
      yield(f)
    end if block_given?
    @sg.each_pair if not block_given?
  end

  def each_obj
    return nil if @sg.empty?
    @sg.each_pair do |f, o|
      yield(o.object)
    end if block_given?
    @sg.each_pair if not block_given?
  end

  def each_pos
    return nil if @sg.empty?
    pos = Array.new
    (@length||@sg.keys.max(&comp('x'))[0]).downto(@sized?1:@sg.keys.min(&comp('x'))[0]).each do |l|
      (@width||@sg.keys.max(&comp('y'))[1]).downto(@sized?1:@sg.keys.min(&comp('y'))[1]).each do |w|
        p = Hash.new
        p[:x] = l
        p[:y] = w
        pos.push(p)
      end
    end
    pos.each do |p|
      yield(p)
    end if block_given?
    pos.each if not block_given?
  end
end
