require 'square_graph/face'

class DummyObject
  attr_accessor :value
  def initialize (value)
    @value = value
  end
end

describe SquareGraph::Face, "#new" do
  it "accepts an x, y, object and can display them easily" do
    f = SquareGraph::Face.new(5, 5, true)
    f.x.should eql(5)
    f.y.should eql(5)
    f.object.should eql(true)
  end
  it "accepts objects too!" do
    du = DummyObject.new(0)
    f = SquareGraph::Face.new(5,5, du)
    f.object.should eql(du)
  end
end

describe SquareGraph::Face, "#truthy?" do
  before(:each) {DummyObject.send(:remove_method, :truthy?) if DummyObject.method_defined? :truthy?}
  it "asks an object whether it is true or not" do
    f = SquareGraph::Face.new(5,5, true)
    f.truthy?.should eql(true)
  end
  it "returns nil if the object doesn't have a truthy method" do
    du = DummyObject.new(0)
    f = SquareGraph::Face.new(5,5, du)
    f.truthy?.should be_nil
  end
  it "accepts a block that will override a truthy method or in replace of a truthy method" do
    du = DummyObject.new(0)
    f = SquareGraph::Face.new(5,5, du)
    (f.truthy?{|o| o.value == 0}).should eql(true)
  end
end

describe SquareGraph::Face, "#u" do
  it "looks above the current face on a squareGraph and returns the face above it" do
    sg = SquareGraph.new
    sg.fill(0,0)
    sg.fill(0,1)
    f = sg.get_face(0,0)
    f = f.u
    f.x.should eql(0)
    f.y.should eql(1)
  end
  it "returns a face" do
    sg = SquareGraph.new
    sg.fill(0,0)
    sg.fill(0,1)
    f = sg.get_face(0,0)
    f = f.u
    f.class.should eql(SquareGraph::Face)
  end
end
