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
  it "should be able to resize if there are no conflicts" do
    #TODO once we create instances, we'll do this later
  end
  it "should not be able to resize if conflicts" do
    #TODO yeah, let's implement this later
  end
  it "should not save len/wid if no parameters are given" do
    sg = SquareGraph.new
    expect {sq.length}.to raise_error
    expect {sq.width}.to raise_error
  end
end
