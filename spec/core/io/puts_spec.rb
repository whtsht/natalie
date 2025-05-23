require_relative '../../spec_helper'
require_relative 'fixtures/classes'

describe "IO#puts" do
  before :each do
    @before_separator = $/
    @name = tmp("io_puts.txt")
    @io = new_io @name
    ScratchPad.record(+"")
    def @io.write(str)
      ScratchPad << str
    end
  end

  after :each do
    ScratchPad.clear
    @io.close if @io
    rm_r @name
    suppress_warning {$/ = @before_separator}
  end

  it "writes just a newline when given no args" do
    @io.puts.should == nil
    ScratchPad.recorded.should == "\n"
  end

  it "writes just a newline when given just a newline" do
    -> { $stdout.puts "\n" }.should output_to_fd("\n", $stdout)
  end

  it "writes empty string with a newline when given nil as an arg" do
    @io.puts(nil).should == nil
    ScratchPad.recorded.should == "\n"
  end

  it "writes empty string with a newline when given nil as multiple args" do
    @io.puts(nil, nil).should == nil
    ScratchPad.recorded.should == "\n\n"
  end

  # NATFIXME: This test fails thinking it should receive method_missing, but when
  # wrapped with NATFIXME() it thinks the test passed, so had to be xit'd
  xit "calls :to_ary before writing non-string objects, regardless of it being implemented in the receiver" do
    object = mock('hola')
    object.should_receive(:method_missing).with(:to_ary)
    object.should_receive(:to_s).and_return("#<Object:0x...>")

    @io.puts(object).should == nil
    ScratchPad.recorded.should == "#<Object:0x...>\n"
  end

  it "calls :to_ary before writing non-string objects" do
    object = mock('hola')
    object.should_receive(:to_ary).and_return(["hola"])

    @io.puts(object).should == nil
    ScratchPad.recorded.should == "hola\n"
  end

  it "calls :to_s before writing non-string objects that don't respond to :to_ary" do
    object = mock('hola')
    object.should_receive(:to_s).and_return("hola")

    @io.puts(object).should == nil
    ScratchPad.recorded.should == "hola\n"
  end

  it "returns general object info if :to_s does not return a string" do
    object = mock('hola')
    object.should_receive(:to_s).and_return(false)

    @io.puts(object).should == nil
    NATFIXME "Object#inspect missing instance-variables causes this to break" do
      ScratchPad.recorded.should == object.inspect.split(" ")[0] + ">\n"
    end
  end

  it "writes each arg if given several" do
    @io.puts(1, "two", 3).should == nil
    ScratchPad.recorded.should == "1\ntwo\n3\n"
  end

  it "flattens a nested array before writing it" do
    @io.puts([1, 2, [3]]).should == nil
    ScratchPad.recorded.should == "1\n2\n3\n"
  end

  it "writes nothing for an empty array" do
    x = []
    @io.should_not_receive(:write)
    @io.puts(x).should == nil
  end

  # NATFIXME: recursion case not handled yet
  xit "writes [...] for a recursive array arg" do
    x = []
    x << 2 << x
    @io.puts(x).should == nil
    ScratchPad.recorded.should == "2\n[...]\n"
  end

  it "writes a newline after objects that do not end in newlines" do
    @io.puts(5).should == nil
    ScratchPad.recorded.should == "5\n"
  end

  it "does not write a newline after objects that end in newlines" do
    @io.puts("5\n").should == nil
    ScratchPad.recorded.should == "5\n"
  end

  it "ignores the $/ separator global" do
    suppress_warning {$/ = ":"}
    @io.puts(5).should == nil
    ScratchPad.recorded.should == "5\n"
  end

  it "raises IOError on closed stream" do
    -> { IOSpecs.closed_io.puts("stuff") }.should raise_error(IOError)
  end

  it "writes crlf when IO is opened with newline: :crlf" do
    NATFIXME "File.open newline arg unsupported", exception: ArgumentError, message: 'unknown keyword: :newline' do
      File.open(@name, 'wt', newline: :crlf) do |file|
        file.puts
      end
      File.binread(@name).should == "\r\n"
    end
  end

  it "writes cr when IO is opened with newline: :cr" do
    NATFIXME "File.open newline arg unsupported", exception: ArgumentError, message: 'unknown keyword: :newline' do
      File.open(@name, 'wt', newline: :cr) do |file|
        file.puts
      end
      File.binread(@name).should == "\r"
    end
  end

  platform_is_not :windows do # https://bugs.ruby-lang.org/issues/12436
    it "writes lf when IO is opened with newline: :lf" do
      NATFIXME "File.open newline arg unsupported", exception: ArgumentError, message: 'unknown keyword: :newline' do
        File.open(@name, 'wt', newline: :lf) do |file|
          file.puts
        end
        File.binread(@name).should == "\n"
      end
    end
  end
end
