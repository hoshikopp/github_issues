class Repository < ApplicationRecord
  belongs_to :organisation
  has_many :issues, dependent: :destroy
  validates :repository_name, uniqueness: true

  def self.exist_repository?(org, repo)
      repo.present? and repo.organisation == org
  end

  def self.getting_form_remote_server(org, repo)
     client = GithubClient.new(org, repo)
     client.get_issues
  end
end
