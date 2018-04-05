require 'net/http'
require 'uri'
require 'json'

class GithubIssueApi
  def initialize(org, repo)
    @org = org
    @repo = repo
    @api_host = api_host
    @endpoint = endpoint
    call
  end

  def issues
    return if @results.nil?
    parse_for_db_saving(@results)
  end

  private
  def api_host
    URI.parse("https://api.github.com/")
  end

  def endpoint
    '/repos/' + @org + '/' + @repo + '/issues'
  end

  def call
    https = Net::HTTP.new(@api_host.host, @api_host.port)
    https.use_ssl = true
    response = https.get(@endpoint)
    case response
    when Net::HTTPSuccess
      @results = JSON.parse(response.body)
    else
      @results = nil
    end
  end

  def result_hash_toarray(result_hash)
    {
      github_id: result_hash['id'],
      title: result_hash['title'].slice(0, 29),
      body: result_hash['body'].slice(0, 49),
      html_url: result_hash['html_url'],
      github_created_at: result_hash['created_at']
    }
  end

  def parse_for_db_saving(results)
    return_array = []
    results.each do |result|
      return_array << result_hash_toarray(result)
    end
    return_array
  end


end
