require 'spec_helper'

describe Character do
  describe "#run" do
    it "should be movement allowance times 3" do
      Character.new(movement_allowance: 6).run.should == 18
      Character.new(movement_allowance: 3).run.should == 9
    end
  end

  describe "#leap" do
    it "should be run divided by 4 rounded down to nearest integer" do
      Character.new(movement_allowance: 6).leap.should == 4
      Character.new(movement_allowance: 3).leap.should == 2
    end
  end

  describe "#body_type_modifier" do
    [2].each do |i|
      it "should be 0 when body type is set to #{i}" do
        Character.new(body_type: i).body_type_modifier.should == 0
      end
    end
    (3..4).each do |i|
      it "should be -1 when body type is set to #{i}" do
        Character.new(body_type: i).body_type_modifier.should == -1
      end
    end
    (5..7).each do |i|
      it "should be -2 when body type is set to #{i}" do
        Character.new(body_type: i).body_type_modifier.should == -2
      end
    end
    (8..9).each do |i|
      it "should be -3 when body type is set to #{i}" do
        Character.new(body_type: i).body_type_modifier.should == -3
      end
    end
    [10].each do |i|
      it "should be -4 when body type is set to #{i}" do
        Character.new(body_type: i).body_type_modifier.should == -4
      end
    end
    [11].each do |i|
      it "should be -4 when body type is set to #{i}" do
        Character.new(body_type: i).body_type_modifier.should == -5
      end
    end
  end
end
