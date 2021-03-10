require 'pry'
require 'rails_helper'

RSpec.describe Project do
  it 'should have both title and content' do
    project = Project.new

    expect(project.valid?).to be(false)
    expect(project.errors.full_messages).to include("Title can't be blank", "Content can't be blank")
  end

  describe 'title should be unique under the same user' do
    context 'when creating project with the same title as an existing project' do
      it 'is invalid' do
        user = FactoryBot.create(:user)
        FactoryBot.create(:project, title: 'project1', user: user)
        project = Project.new(title: 'project1', content: 'content1', user: user)

        expect(project.valid?).to be(false)
        expect(project.errors.full_messages).to include('Title has already been taken')
      end
    end

    context 'when creating project with the same title as an existing project that is not his own' do
      it 'is valid' do
        user = FactoryBot.create(:user)
        other_user = FactoryBot.create(:user)

        FactoryBot.create(:project, title: 'project1', user: other_user)
        project = FactoryBot.build(:project, title: 'project1', user: user)

        expect(project.valid?).to be(true)
      end
    end
  end

  it 'can change status' do
    project = FactoryBot.create(:project, title: 'project1', content: 'content1')
    project.doing!
    expect(project.doing?).to eq(true)
    expect(project.status).to eq('doing')

    project.done!
    expect(project.done?).to eq(true)
    expect(project.status).to eq('done')
  end

  it 'can change priority' do
    project = FactoryBot.create(:project, title: 'project1', content: 'content1')
    expect(project.low_priority?).to eq(true)
    expect(project.priority).to eq('low')

    project.medium_priority!
    expect(project.medium_priority?).to eq(true)
    expect(project.priority).to eq('medium')

    project.high_priority!
    expect(project.high_priority?).to eq(true)
    expect(project.priority).to eq('high')
  end

  describe 'start_date cannot be earlier than due_date' do
    context 'when start date is not specified' do
      it 'is valid' do
        project = FactoryBot.build(:project,
                                   start_date: nil,
                                   due_date: Date.today + 1)
        expect(project.valid?).to be(true)
      end
    end

    context 'when due date is later than start date' do
      it 'is valid' do
        project = FactoryBot.build(:project,
                                   start_date: Date.today + 1,
                                   due_date: Date.today + 2)
        expect(project.valid?).to be(true)
      end
    end

    context 'when due date is earlier than start date' do
      it 'is invalid' do
        project = FactoryBot.build(:project,
                                   start_date: Date.today + 2,
                                   due_date: Date.today + 1)
        expect(project.valid?).to be(false)
        expect(project.errors.full_messages).to include("Due date can't be earlier than start date")
      end
    end
  end

  context '#search' do
    before do
      project_titles = ['Dr. Bradly Monahan', 'Luigi Wolf',
                        'Vernon Pouros', 'Grover Considine', 'Jimmie Wilkinson', 'react tutorial']
      project_contents = ['Rails PMS', 'Rails Blog', 'Rails & React chat app']

      project_titles.each do |title|
        FactoryBot.create(:project, title: title)
      end
      project_contents.each do |content|
        FactoryBot.create(:project, content: content)
      end
    end

    context 'searhc with all lowercase' do
      it 'returns all projects whose content contains search query' do
        expected_project_contents = ['Rails PMS', 'Rails Blog', 'Rails & React chat app']
        actual_project_contents = Project.search('rails').map(&:content)
        expect(actual_project_contents).to match_array(expected_project_contents)
      end
    end

    context 'searhc with all uppercase' do
      it 'returns all projects whose content contains search query' do
        expected_project_contents = ['Rails PMS', 'Rails Blog', 'Rails & React chat app']
        actual_project_contents = Project.search('RAILS').map(&:content)
        expect(actual_project_contents).to match_array(expected_project_contents)
      end
    end

    context 'search terms that appear in project content and title ' do
      it 'returns all projects whose content contains search query' do
        results = Project.search('react')
        actual_project_contents = results.map(&:content)
        actual_project_titles = results.map(&:title)
        actual_result = actual_project_titles + actual_project_contents
        expect(actual_result).to include('react tutorial', 'Rails & React chat app')
      end
    end
  end
end
