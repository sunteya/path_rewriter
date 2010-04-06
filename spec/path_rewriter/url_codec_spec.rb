require 'spec_helper'

describe PathRewriter::UrlCodec do
  
  before(:each) do
    @codec = PathRewriter::UrlCodec.new
  end
  
  it "should skip decode uri" do
    @codec.decode("/request/foo.bar").should == "/request/foo.bar"
    @codec.decode("/request/controller/foo.bar").should == "/request/controller/foo.bar"
  end
  
  it "should decode uri success" do
    @codec.base_path = "/request"

    @codec.decode("/").should == "/request"
    @codec.decode("/foo").should == "/request/foo"
    @codec.decode("/?123").should == "/request?123"
    @codec.decode("/controller/foo.bar").should == "/request/controller/foo.bar"
  end
  
  it "should decode uri by namespace with root_path" do
    @codec.root_path = "/root"
    @codec.base_path = "/request"
    @codec.decode("/root/bar").should == "/root/request/bar"
  end
  
  it "should encode uri" do
    @codec.encode("/foo?123").should == "/foo?123"
    @codec.encode("/").should == "/"
  end
  
  it "should encode uri by namespace" do
    @codec.base_path = "/request"
    @codec.encode("/request/foo?123").should == "/foo?123"
    @codec.encode("/request/").should == "/"
    @codec.encode("/request").should == "/"
  end
  
  it "should encode uri by namespace with root" do
    @codec.root_path = "/root"
    @codec.base_path = "/request"
    @codec.encode("/root/request/bar").should == "/root/bar"
  end
end
