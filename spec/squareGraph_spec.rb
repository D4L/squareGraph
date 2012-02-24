require 'squareGraph'

describe SquareGraph, '#new' do
  it "should accept two parameters" do
    SquareGraph.new(5,5).should_not be_nil
  end
  it "should error when given one parameter" do
    expect {SquareGraph.new(0)}.to raise_error(ArgumentError, "Only zero or two parameters")
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
    expect {SquareGraph.new(0,5)}.to raise_error(ArgumentError)
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
    expect {sg.resize(0, -1)}.to raise_error(ArgumentError)
  end
  it "should not be able to resize if conflicts" do
    #TODO yeah, let's implement this later
  end
end

describe SquareGraph, "#fill" do
  it "simply fills in a location with a simple TrueClass" do
    sg = SquareGraph.new(5,5)
    sg.fill(2,2)
    sg.get(2,2).should eql(true)
  end
end

describe SquareGraph, "#insert" do
  it "fills a location with an object" do
    #TODO this one gets rly hard.
  end
end

