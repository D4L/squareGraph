require 'square_graph'

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
    sg.get(2,2).should eql(true)
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
    sg.get(-1, -3).should eql(true)
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
    sg.get(2,2).should eql(true)
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
    (1..6).each {|x| sg.get(x-1, x-1).should eql(true)}
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
    sg.get(3, 3).should eql(true)
    sg.clear
    sg.empty?.should eql(true)
  end
  it "informs us even if we just remove the items" do
    sg = SquareGraph.new
    sg.fill(0,0)
    sg.remove(0, 0)
    sg.empty?.should eql(true)
  end
  it "returns false if the graph isn't empty" do
    sg = SquareGraph.new
    sg.fill(0,0)
    sg.empty?.should eql(false)
  end
end

describe SquareGraph, "#each" do
  it "goes through each filled position and allows us to do stuff with them" do
    sg = SquareGraph.new(4,4)
    sg.fill(2,2)
    sg.fill(1,1)
    sg.fill(1,2)
    sg.each {|f| @sg.delete(f.x, f.y)}
  end
end
