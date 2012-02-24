require 'face'

describe Face, '#new' do
  it "accepts an x, y, object and can display them easily" do
    a = Face.new(5, 5, true)
    a.x.should eql(5)
    a.y.should eql(5)
    a.object.should eql(true)
  end
end

describe Face, '#get_truthy' do
  #TODO this will be fun, basically, it will get the truth value of the object
end
