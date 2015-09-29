require 'cucumber/website/core/entities'

module Cucumber
module Website
  class FakeCommunityLoader
  end

  class GitHubCommunityLoader
  end

  # TODO: switch based on environment
  CommunityLoader = FakeCommunityLoader
end
end
