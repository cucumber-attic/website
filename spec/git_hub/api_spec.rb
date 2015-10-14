require 'cucumber/website/git_hub/api'
require 'cucumber/website/config'

module Cucumber::Website
  module GitHub
    describe API do
      let(:config) { Config.new('test') }
      before do
        skip("Please set GIT_HUB_TOKEN to run this test") unless config['git_hub_token']
      end

      it "fetches events" do
        events = API.new(config).events
        expect(events).to_not be_empty
        expect(events.first.contributor.username).to_not be_empty
        expect(events.first.contributor.avatar_url).to_not be_empty
      end
    end
  end
end
