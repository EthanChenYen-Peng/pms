require 'rails_helper'

RSpec.describe Project do
  it 'should have both title and content' do
    project = Project.new
    project.save

    expect(project.errors.any?).to be(true)
    expect(project.errors[:title]).to match_array(["can't be blank"])
    expect(project.errors[:content]).to match_array(["can't be blank"])
  end

  it 'title should be unique' do
    FactoryBot.create(:project, title: 'project1')
    project = Project.new(title: 'project1', content: 'content1')

    project.save
    expect(project.errors.any?).to be(true)
    expect(project.errors[:title]).to match_array(['has already been taken'])
  end
end
