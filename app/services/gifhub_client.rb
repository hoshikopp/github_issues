require 'net/http'
require 'uri'
require 'json'

class GithubIssueAPI
  def initialize
    @org = org
    @repo = repo

  end

end
