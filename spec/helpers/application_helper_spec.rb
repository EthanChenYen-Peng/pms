require 'rails_helper'

FakeRequest = Struct.new(:path)

RSpec.describe ApplicationHelper do
  describe '#switch_locale_path' do
    it 'convert the locale to zh-TW' do
      helper.stub(:locale) { :en }
      expected_paths = ['/zh-TW/projects/1', '/zh-TW']

      ['/en/projects/1', '/'].each_with_index do |path, index|
        helper.stub(:request) { FakeRequest.new(path) }

        expect(helper.switch_locale_path(:"zh-TW")).to eq(expected_paths[index])
      end
    end

    it 'convert the locale to en' do
      helper.stub(:locale) { :'zh-TW' }
      expected_paths = ['/en/projects/1', '/en']

      ['/zh-TW/projects/1', '/zh-TW'].each_with_index do |path, index|
        helper.stub(:request) { FakeRequest.new(path) }

        expect(helper.switch_locale_path(:en)).to eq(expected_paths[index])
      end
    end
  end

  describe '#better_distance_of_time_in_words' do
    context 'future event' do
      it 'displays times to event' do
        future_date = helper.better_distance_of_time_in_words(Time.now + 2.day)
        expect(future_date).to eq('in 2 days')
      end
    end

    context 'past event' do
      it 'displays times ago since the event has started' do
        past_date = helper.better_distance_of_time_in_words(Time.now - 2.day)
        expect(past_date).to eq('2 days ago')
      end
    end
  end

  describe '#enum_name' do
    it 'displays project priority' do
      helper.stub(:locale) { :en }
      expect(helper.enum_name('project', 'priority', 'low')).to eq('Low')
      expect(helper.enum_name('project', 'priority', 'medium')).to eq('Medium')
      expect(helper.enum_name('project', 'priority', 'high')).to eq('High')
    end

    it 'displays project status' do
      helper.stub(:locale) { :en }
      expect(helper.enum_name('project', 'status', 'todo')).to eq('Todo')
      expect(helper.enum_name('project', 'status', 'doing')).to eq('Doing')
      expect(helper.enum_name('project', 'status', 'done')).to eq('Done')
    end
  end

end
