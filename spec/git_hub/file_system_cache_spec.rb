require 'cucumber/website/git_hub/file_system_cache'
require 'cucumber/website/core/git_hub_event'
require 'cucumber/website/core/contributor'
require 'cucumber/website/config'

module Cucumber::Website
  module GitHub
    describe FileSystemCache do
      let(:api) { double("API", events: some_events) }
      let(:config) { Config.new('test') }
      let(:cache) { FileSystemCache.new(api, config) }
      let(:some_events) do
        [
          Cucumber::Website::Core::GitHubEvent.with(
            contributor: Cucumber::Website::Core::Contributor.with(
              avatar_url: 'https://github.com/avatar/123',
              username: 'Charlie')
          )
        ]
      end

      context "when the cache is empty" do
        before { cache.flush }

        it "forwards calls the API" do
          cache.events
        end

        it "returns the API response when called for the first time" do
          expect(cache.events).to eq some_events
        end

        it "returns the cached API response on subsequent calls" do
          expect(api).to receive(:events).at_most(:once)
          cache.events
          cache.events
        end
      end

      context "when the cache has been recently populated" do
        before do
          cache.flush
          cache.events
        end

        it "does not call the API" do
          expect(api).to_not receive(:events)
          cache.events
        end

        it "returns the value from the cache" do
          expect(cache.events).to eq some_events
        end

        context "another instance" do
          let(:another_cache) { FileSystemCache.new(api, config) }

          it "does not call the API" do
            expect(api).to_not receive(:events)
            another_cache.events
          end

          it "returns the value from the cache" do
            expect(another_cache.events).to eq some_events
          end
        end
      end

      context "when the cache is outdated" do
        before do
          cache.flush
          cache.events
          File.mtime cache.send(:cache_path), mtime: Time.now - (config['git_hub']['cache_refresh_interval'] + 1)
        end

        it "calls the API"
        it "returns the latest API response on subsequent calls"
      end
    end
  end
end
