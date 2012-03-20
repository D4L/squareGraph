class SquareGraph::Face
  attr_accessor :x, :y, :object
  def initialize(x, y, object)
    @x = x
    @y = y
    @object = object
  end

  def truthy?(&alt)
    if alt
      return alt.call(object)
    end
    (object == true) || (object.truthy? if object.respond_to? :truthy?)
  end

  def u
    p self.instance_variables
  end
end
