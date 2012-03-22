class SquareGraph::Face
  attr_accessor :x, :y, :object, :sg
  def initialize(x, y, object, *sg)
    @x = x
    @y = y
    @object = object
    @sg = sg[0] if sg[0]
  end

  def truthy?(&alt)
    if alt
      return alt.call(object)
    end
    (object == true) || (object.truthy? if object.respond_to? :truthy?)
  end

  def u
    @sg.get_face(@x, @y + 1)
  end
end
