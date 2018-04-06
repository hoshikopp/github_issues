class Issue < ApplicationRecord
  belongs_to :repository
  validates :github_id, uniqueness: true
end
