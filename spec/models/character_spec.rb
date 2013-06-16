require 'spec_helper'

describe Character do
  it "should auto generate career skills when assigned a role" do
    seed!

    role = Role.find_by(name: "Solo")

    character = Character.new(role: role)
    character.skills.length.should == role.career_skill_ids.length
    character.skills.select(&:career?).collect(&:skill_id).should include(*role.career_skill_ids)

    character = Character.new(role_id: role.id)
    character.skills.length.should == role.career_skill_ids.length
    character.skills.select(&:career?).collect(&:skill_id).should include(*role.career_skill_ids)
  end

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
end
