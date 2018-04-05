require 'net/http'
require 'uri'
require 'json'

class GithubClient
  def initialize(org, repo)
    @org = org
    @repo = repo
  end

  def get_issues
    GithubIssueApi.new(@org, @repo).issues
  end

end
