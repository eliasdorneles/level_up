require 'spec_helper'

describe UncompleteSkill do
  let!(:completion) { create(:completion, skill: skill, user: user) }
  let(:user)        { create(:user) }
  let(:skill)       { create(:skill) }

  it "allows the user to uncomplete a skill" do
    interactor = UncompleteSkill.new(skill: skill, user: user).call

    expect(interactor).to be_success
    expect(user.skills).not_to include(skill)
  end

  it "doesn't allow uncompletion for an incomplete skill" do
    skill = create(:skill)

    interactor = UncompleteSkill.new(skill: skill, user: user).call
    expect(interactor).not_to be_success
  end
end
