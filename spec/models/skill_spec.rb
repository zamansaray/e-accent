require 'rails_helper'

describe Skill do
  before :each do
    @skill = build :skill
  end

  subject { @skill }

  it { should be_valid }

  describe 'validations' do
    it 'should have a name' do
      @skill.name = nil
      expect(@skill).to_not be_valid
    end

    it 'should have a name' do
      other_skill = create :skill
      @skill.name = other_skill.name
      expect(@skill).to_not be_valid
    end
  end
end
