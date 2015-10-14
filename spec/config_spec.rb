require 'cucumber/website/config'

module Cucumber::Website
  describe Config do
    it "parses the file with YAML" do
      ENV['TEST'] = 'test value'
      config = Config.new('test')
      expect(config['test']).to eq 'test value'
    end
  end
end
