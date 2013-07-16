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

  describe "#lift" do
    it "is body type times 40" do
      Character.new(body_type: 6).lift.should == 240
      Character.new(body_type: 3).lift.should == 120
    end
  end

  describe "#carry" do
    it "is body type times 10" do
      Character.new(body_type: 6).carry.should == 60
      Character.new(body_type: 3).carry.should == 30
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

  describe "#actual_empathy" do
    it "reduces empathy by 1 for every 10 loss to base humanity" do
      character = Character.new(empathy: 8)
      character.actual_empathy.should == 8

      character.stub(:humanity).and_return(79.5)
      character.actual_empathy.should == 8

      character.stub(:humanity).and_return(70.4)
      character.actual_empathy.should == 8

      character.stub(:humanity).and_return(70)
      character.actual_empathy.should == 7
    end
  end
end
