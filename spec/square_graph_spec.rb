require 'square_graph'

class DummyObject
  attr_accessor :value
  def initialize (value)
    @value = value
  end
end

describe SquareGraph, '#new' do
  it "should accept two parameters" do
    SquareGraph.new(5,5).should_not be_nil
  end
  it "should error when given one parameter" do
    expect {SquareGraph.new(0)}.to raise_error(ArgumentError)
  end
  it "should accept no parameters" do
    SquareGraph.new.should_not be_nil
  end
  it "should save if two parameters given as length, width" do
    sg = SquareGraph.new(5,10)
    sg.length.should eq(5)
    sg.width.should eq(10)
  end
  it "should only save integers into the parameters" do
    expect {SquareGraph.new("lalaland", "luftland")}.to raise_error(ArgumentError)
  end
  it "should only save positive integers into the parameters" do
    expect {SquareGraph.new(0, 5)}.to raise_error(ArgumentError)
    expect {SquareGraph.new(5,-1)}.to raise_error(ArgumentError)
  end
  it "should not save len/wid if no parameters are given" do
    sg = SquareGraph.new
    expect {sq.length}.to raise_error
    expect {sq.width}.to raise_error
  end
end

describe SquareGraph, "#resize" do
  it "resizes dimentioned graphs given two parameters" do
    sg = SquareGraph.new(5,5)
    sg.resize(10,10)
    sg.length.should eq(10)
    sg.width.should eq(10)
  end
  it "should not resize dimentionless graphs" do
    sg = SquareGraph.new
    expect {sg.resize(1,1)}.to raise_error(NoMethodError)
  end
  it "should only resize to valid sizes" do
    sg = SquareGraph.new(5,5)
    sg.resize(0, -1).should be_nil
  end
  it "should not be able to resize if conflicts" do
    sg = SquareGraph.new(5, 5)
    sg.fill(5, 5)
    sg.resize(4, 4).should be_nil
  end
end

describe SquareGraph, "#fill, #get" do
  it "fills a single position with a TrueClass and gets it back with get" do
    sg = SquareGraph.new(5,5)
    sg.fill(2,2)
    sg.get(2,2).should be_true
  end
  it "can also fill a single position with an object by specifying a third parameter" do
    du = DummyObject.new (3)
    sg = SquareGraph.new(5,5)
    sg.fill(3,3,du)
    sg.get(3,3).should eql(du)
  end
  it "cannot fill spots with falsey things" do
    sg = SquareGraph.new
    sg.fill(0,0, nil).should be_nil
    sg.objects.should be_nil
  end
  it "allows weird fills" do
    sg = SquareGraph.new
    du = DummyObject.new(nil)
    sg.fill(0,0,du)
    sg.get(0,0).value.should be_nil
  end
  it "can fill spots with nil to act as delete" do
    sg = SquareGraph.new
    sg.fill(0,0)
    sg.objects.size.should eql(1)
    sg.fill(0,0,nil).should be_nil
    sg.empty?.should be_true
  end
  it "doesn't allow fills of outside the graph" do
    sg = SquareGraph.new(5,10)
    sg.fill(10, 2).should be_nil
    sg.fill(2, 11).should be_nil
    sg.fill(0, 0).should be_nil
    #TODO there should be a better way to implement these.. srsly
  end
  it "doesn't allow random values" do
    sg = SquareGraph.new(2,2)
    expect {sg.fill("blah", 10)}.to raise_error(ArgumentError)
    expect {sg.fill(0.1, 2)}.to raise_error(ArgumentError)
  end
  it "allows undimentioned graphs to fill anywhere, even negative" do
    sg = SquareGraph.new
    sg.fill(2,2)
    sg.fill(-1, -3)
    sg.get(-1, -3).should be_true
  end
  it "nils if getting something that doesn't exist yet" do
    sg = SquareGraph.new
    sg.get(0,0).should be_nil
  end
  it "nils when getting something out of the range of the graph" do
    sg = SquareGraph.new(5,5)
    sg.get(2,2).should be_nil
    sg.get(10,10).should be_nil
  end
  it "return nil when filling a position that's already filled" do
    sg = SquareGraph.new
    sg.fill(0,0)
    sg.fill(0,0).should be_nil
  end
end

describe SquareGraph, "#get_face" do
  it "gets the entire face as opposed to just the object" do
    sg = SquareGraph.new
    sg.fill(0,0)
    f = sg.get_face(0,0)
    f.x.should eql(0)
    f.y.should eql(0)
    f.object.should be_true
  end
end

describe SquareGraph, "#insert" do
  it "fills a location with an object" do
    #TODO this one gets rly hard. don't know if we should put it into fill
  end
end

describe SquareGraph, "#remove" do
  it "removes any objects from a certain position" do
    sg = SquareGraph.new
    sg.fill(2,2)
    sg.get(2,2).should be_true
    sg.remove(2,2)
    sg.get(2,2).should be_nil
  end
  it "returns nil if there was nothing in the position" do
    sg = SquareGraph.new
    sg.remove(2, 2).should be_nil
  end
  it "returns nil if you try and remove something outside of rannge" do
    sg = SquareGraph.new(5, 5)
    sg.remove(10, 10).should be_nil
  end
end

describe SquareGraph, "#clear" do
  it "removes every object in the graph" do
    sg = SquareGraph.new
    (0..5).each {|x| sg.fill(x, x)}
    (1..6).each {|x| sg.get(x-1, x-1).should be_true}
    sg.clear
    (2..7).each {|x| sg.get(x-2, x-2).should be_nil}
  end
end

describe SquareGraph, "#empty?" do
  it "informs us if SquareGraph is empty, ie, if none of the positions are filled" do
    sg = SquareGraph.new(5, 5)
    (1..5).each do |x|
      (1..5).each do |y|
        sg.fill(x,y)
      end
    end
    sg.get(3, 3).should be_true
    sg.clear
    sg.empty?.should be_true
  end
  it "informs us even if we just remove the items" do
    sg = SquareGraph.new
    sg.fill(0,0)
    sg.remove(0, 0)
    sg.empty?.should be_true
  end
  it "returns false if the graph isn't empty" do
    sg = SquareGraph.new
    sg.fill(0,0)
    sg.empty?.should eql(false)
  end
end

describe SquareGraph, "#each_pos" do
  it "returns a each loop where the value is a 2 value'd array containing x,y" do
    i = 0
    sg = SquareGraph.new(5,5)
    sg.fill(3,3)
    sg.each_pos do |p|
      i += 1 if sg.get(p[:x], p[:y])
    end
    i.should eql(1)
  end
  it "returns a enumerator class if run my itself" do
    sg = SquareGraph.new(5,5)
    sg.fill(3,3)
    sg.each_pos.class.should eql(Enumerator)
  end
  it "works for non-dimentioned graphs by using the max/min points" do
    sg = SquareGraph.new
    sg.fill(0,0)
    sg.fill(2,2)
    i = 0
    sg.each_pos do |p|
      i += 1
    end
    i.should eql(9)
  end
  it "works if there are negative positions too" do
    sg = SquareGraph.new
    sg.fill(-3, -4)
    sg.fill(1, 4)
    sg.fill(-1, 8)
    i = 0
    sg.each_pos do |p|
      i += 1
    end
    i.should eql(65)
  end
end

describe SquareGraph, "#each_obj" do
  it "returns an each loop where the value is every object in the graph" do
    sg = SquareGraph.new
    a = DummyObject.new(1)
    b = DummyObject.new(2)
    c = DummyObject.new(3)
    d = DummyObject.new(4)
    e = DummyObject.new(5)
    total = 0
    sg.fill(0,0,a)
    sg.fill(0,1,b)
    sg.fill(0,2,c)
    sg.fill(0,3,d)
    sg.fill(0,4,e)
    sg.each_obj do |o|
      total += o.value
    end
    total.should eql(15)
  end
  it "returns an enumerator class if run my itself" do
    sg = SquareGraph.new
    sg.fill(0,0)
    sg.each_obj.class.should eql(Enumerator)
  end
end

describe SquareGraph, "#[][]" do
  it "does the same thing get does" do
    #TODO do this stuff later patches this is epics
    #sg = SquareGraph.new
    #sg.fill(0,0)
    #sg[0][0].should be_true
  end
end

describe SquareGraph, "#[][]=" do
  it "does the same thing fill does" do
    #TODO dothis stuff later, if you need reminder, need row and column classes
    #sg = SquareGraph.new
    #sg[0][0] = true
    #sg[0][0].should be_true
  end
end

describe SquareGraph, "#objects" do
  it "returns an array of all the objects" do
    sg = SquareGraph.new
    sg.fill(0,0)
    sg.fill(2,2)
    sg.fill(3,3)
    sg.objects.each do |i|
      i.should be_true
    end
  end
  it "returns nil if there aren't any objects" do
    sg = SquareGraph.new
    sg.objects.should be_nil
  end
end

describe SquareGraph, "#truthy?" do
  it "checks if any of the objects result in truthy" do
    sg = SquareGraph.new
    sg.truthy?.should eql(false)
    sg.fill(0,0)
    sg.truthy?.should be_true
  end
  it "lets users pass a block that will be used as truthy? for each object" do
    sg = SquareGraph.new
    du = DummyObject.new(0)
    sg.fill(0,0, du)
    sg.truthy?{|o| o.value == 0}.should be_true
    sg.truthy?{|o| o.value == 1}.should eql(false)
  end
end

describe SquareGraph, "#falsey?" do
  it "checks if any of the objects results in falsey" do
    sg = SquareGraph.new
    sg.falsey?.should eql(false)
    sg.fill(0,0)
    sg.falsey?.should eql(false)
  end
end
describe SquareGraph, "#truthy" do
  it "returns a SquareGraph that contains only the truthy elements" do
    sg = SquareGraph.new
    sg.fill(0,0)
    tsg = sg.truthy
    sg.should eq(tsg)
  end
  it "returns nil if there aren't any truthy objects" do
    sg = SquareGraph.new
    sg.truthy?.should eql(false)
    sg.truthy.should be_nil
  end
end

describe SquareGraph, "#need_truthy" do
  before(:each) {DummyObject.send(:remove_method, :truthy?) if DummyObject.method_defined? :truthy?}
  it "provides an array of all the classes in the squareGraph that need a truthy method" do
    sg = SquareGraph.new
    du = DummyObject.new(0)
    sg.fill(0,0, du)
    sg.need_truthy.include?(DummyObject).should be_true
  end
  it "returns nil if there all the elements in the squareGraph have a truthy method" do
    sg = SquareGraph.new
    du = DummyObject.new(0)
    tehTruthy = Proc.new do
      p "hello world"
    end
    SquareGraph.create_truthy(DummyObject, &tehTruthy)
    sg.need_truthy.should be_nil
  end
end

describe SquareGraph, ".create_truthy" do
  before(:each) {DummyObject.send(:remove_method, :truthy?) if DummyObject.method_defined? :truthy?}
  it "helps define truthy methods for classes" do
    sg = SquareGraph.new
    du = DummyObject.new(0)
    SquareGraph.create_truthy(DummyObject) do
      value == 0
    end
    du.truthy?.should be_true
  end
  it "will nil if truthy is already defined" do
    sg = SquareGraph.new
    du = DummyObject.new(0)
    SquareGraph.create_truthy(DummyObject) do
      value == 1
    end
    du.truthy?.should eql(false)
    SquareGraph.create_truthy(DummyObject) do
      value == 0
    end.should be_nil
    du.truthy?.should eql(false)
  end
end

describe SquareGraph, ".create_truthy!" do
  before(:each) {DummyObject.send(:remove_method, :truthy?) if DummyObject.method_defined? :truthy?}
  it "does the same as .create_truthy" do
    sg = SquareGraph.new
    du = DummyObject.new(0)
    SquareGraph.create_truthy!(DummyObject) do
      value == 0
    end
    du.truthy?.should be_true
  end
  it "overwrite truthy methods!" do
    sg = SquareGraph.new
    du = DummyObject.new(0)
    SquareGraph.create_truthy(DummyObject) do
      value == 1
    end
    du.truthy?.should eql(false)
    SquareGraph.create_truthy!(DummyObject) do
      value == 0
    end.should_not be_nil
    du.truthy?.should be_true
  end
end

describe SquareGraph, "#each" do
  it "returns an iterator of faces." do
    sg = SquareGraph.new
    sg.fill(0,0)
    sg.fill(1,1)
    sg.each do |f|
      f.truthy?.should be_true
    end
  end
end

describe SquareGraph, "#==" do
  it "compares two squaregraphs without identites" do
    sg1 = SquareGraph.new
    sg2 = SquareGraph.new
    (sg1 == sg2).should be_true
    sg1.should == sg2
  end
  it "compares objects without identies too" do
    du = DummyObject.new(5)
    sg1 = SquareGraph.new
    sg2 = SquareGraph.new
    sg1.fill(0,0,du)
    sg2.fill(0,0,du)
    (sg1 == sg2).should be_true
    sg1.should == sg2
  end
end

describe SquareGraph, "#neighbours" do
  it "selects the neighbours of the point specified, and return them in an array of Faces" do
    sg1 = SquareGraph.new
    sg1.fill(0,0)
    sg1.fill(1,1)
    sg1.fill(-1,1)
    neighbourz = sg1.neighbours([0,1])
    neighbourz.class.should eql(Array)
  end
  it "selects immediate neighbors in a 1 block radius" do
    sg1 = SquareGraph.new
    sg1.fill(0,0)
    sg1.fill(1,1)
    sg1.fill(-1,1)
    sg1.fill(1,2)
    sg1.fill(4,3)
    neighbourz = sg1.neighbours([0,1])
    tru_nei = 0
    neighbourz.each do |f|
      tru_nei += 1 if f.truthy?
    end
    tru_nei.should eql(4)
  end
  it "can accept a face object and return it's neighbours" do
    sg1 = SquareGraph.new
    sg1.fill(0,0)
    sg1.fill(1,1)
    sg1.fill(0,1)
    sg1.each do |f|
      sg1.neighbours(f).size.should eql(2)
    end
  end
end
