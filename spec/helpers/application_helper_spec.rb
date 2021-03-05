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
end
