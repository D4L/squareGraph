class SquareGraph

  def truthy
    if @sized
      result = SquareGraph.new(@length, @width)
    else
      result = SquareGraph.new
    end
    @sg.each_pair do  |p, f|
      result.fill(f.x, f.y, f.object) if f.truthy?
    end
    return nil if result.objects.nil?
    result
  end

  def need_truthy
    result = Array.new
    @sg.each_pair do |p, f|
      result.push(f.object.class) if not f.object.class.method_defined? :truthy?
    end
    return nil if result.empty?
    result
  end

  def self.create_truthy (objClass, &truthyMethod)
    return nil if objClass.method_defined? :truthy?
    objClass.send :define_method, :truthy?, truthyMethod
  end

  def self.create_truthy! (objClass, &truthyMethod)
    objClass.send :define_method, :truthy?, truthyMethod
  end

  def truthy? (&alt_cond)
    return false if @sg.size == 0
    @sg.each_pair do |p, f|
      return false if not f.truthy?(&alt_cond)
    end
    true
  end

  def falsey?
    return false if @sg.size == 0
    self.truthy.nil?
  end

end
