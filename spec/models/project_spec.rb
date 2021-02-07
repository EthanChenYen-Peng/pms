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

  it 'can change status' do
    project = Project.new(title: 'project1', content: 'content1')
    project.doing!
    expect(project.doing?).to eq(true)
    expect(project.status).to eq('doing')

    project.done!
    expect(project.done?).to eq(true)
    expect(project.status).to eq('done')
  end

  it 'can change priority' do
    project = Project.new(title: 'project1', content: 'content1')
    expect(project.low_priority?).to eq(true)
    expect(project.priority).to eq('low')

    project.medium_priority!
    expect(project.medium_priority?).to eq(true)
    expect(project.priority).to eq('medium')

    project.high_priority!
    expect(project.high_priority?).to eq(true)
    expect(project.priority).to eq('high')
  end

  context '#title_contains' do
    before do
      Project.delete_all
      names = ['Dr. Bradly Monahan', 'Rep. Gertrudis Schaefer', 'Zachary Nader', 'Efrain Gulgowski PhD', 'Jaime Stehr',
               'Man Mayert', 'Williemae Denesik', 'Will Beer', 'Cecil Williamson', 'Jerrod Howell', 'Jefferson Murphy', 'Luigi Wolf', 'Vernon Pouros', 'Grover Considine', 'Jimmie Wilkinson']

      names.each do |name|
        FactoryBot.create(:project, title: name)
      end
    end

    scenario 'search with lowercase' do
      expected_project_titles = ['Cecil Williamson', 'Jimmie Wilkinson', 'Will Beer', 'Williemae Denesik']
      actual_project_titles = Project.title_contains('wil').map(&:title)
      expect(actual_project_titles).to match_array(expected_project_titles)
    end

    scenario 'search with uppercase' do
      expected_project_titles = ['Cecil Williamson', 'Jimmie Wilkinson', 'Will Beer', 'Williemae Denesik']
      actual_project_titles = Project.title_contains('WIL').map(&:title)
      expect(actual_project_titles).to match_array(expected_project_titles)
    end
  end
end
