require 'octokit'
require 'cucumber/website/core/git_hub_event'
require 'cucumber/website/core/contributor'

module Cucumber
  module Website
    module GitHub

      class API
        def initialize(config)
          @config = config
        end

        def events
          gh.organization_events('cucumber').map { |raw_event|
            actor = raw_event.actor
            Core::GitHubEvent.with({
              contributor: Core::Contributor.with({
                username: actor.login,
                avatar_url: actor.avatar_url
              })
            })
          }
        end

        private

        def gh
          return @gh if @gh
          gh_token = @config['git_hub']['token'] || raise("Please provide a GitHub access token")
          @gh = Octokit::Client.new({ access_token: gh_token })
        end

      end
    end

  end
end
