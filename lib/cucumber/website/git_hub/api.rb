require 'octokit'
require 'cucumber/website/core/git_hub_event'
require 'cucumber/website/core/contributor'

module Cucumber
  module Website
    module GitHub

      class API
        def initialize(config)
          @gh = Octokit::Client.new({ access_token: config['git_hub']['token'] })
          @logger = Logger.new($stderr)
        end

        def events
          @gh.organization_events('cucumber').map { |raw_event|
            actor = raw_event.actor
            Core::GitHubEvent.with({
              contributor: Core::Contributor.with({
                username: actor.login,
                avatar_url: actor.avatar_url
              })
            })
          }
        rescue Octokit::NotFound => e
          @logger.debug(e.message)
          @logger.info("Stop fetching GitHub Events, they won't be refreshed")
          []
        end
      end
    end

  end
end
