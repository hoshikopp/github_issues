require 'net/http'
require 'uri'
require 'json'

class GithubIssueAPI
  def initialize
    @org = org
    @repo = repo
    @api_host = api_host
    @endpoint = endpoint
    call
  end

  def api_host
    URL.parse("https://api.github.com/")
  end

  def endpoint
    '/repos' + @org + '/' + @repo + '/issues'
  end

  def call
    https = Net::HTTP.new(@api_host, @endpoint)
    https.use_ssl = true
    response = https.get(@endpoint)
    case response
    when Net::HTTPSuccess
      @results = JSON.parse(response.body)
    else
      @results = nil
    end
  end


end
