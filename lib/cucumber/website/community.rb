require 'values'

module Cucumber
module Website
  Contributor = Value.new(:avatar_url, :username)
  Community   = Value.new(:recent_contributors)

  class FakeCommunityLoader
    @max_recent_contributors = 10
    @recent_github_contributors = []

    class << self
      attr_accessor :max_recent_contributors, :recent_github_contributors
    end

    def call
      Community.with(recent_contributors: self.class.recent_github_contributors.uniq.take(self.class.max_recent_contributors).map { |username|
       Contributor.with(avatar_url: "https://avatars.githubusercontent.com/u/#{rand(10000)}", username: username) })
    end

    def refresh
      CONFIG['site']['community'] = call
    end
  end

  class GitHubCommunityLoader
  end

  # TODO: switch based on environment
  CommunityLoader = FakeCommunityLoader
end
end
