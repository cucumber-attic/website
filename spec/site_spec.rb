require 'cucumber/website/core/site'
require 'cucumber/website/core/git_hub_event'
require 'cucumber/website/core/contributor'

module Cucumber::Website::Core
  describe Site do
    describe "#community" do
      it "has a list of unique contributors" do

        git_hub = double(events: [
          GitHubEvent.with(contributor: Contributor.with(username: "charlierudolph", avatar_url: "")),
          GitHubEvent.with(contributor: Contributor.with(username: "charlierudolph", avatar_url: ""))
        ])
        site = Site.new(double, double, git_hub)
        expect(site.community.contributors.length).to eq 1
      end
    end
  end
end
