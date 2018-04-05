class Repository < ApplicationRecord
  belongs_to :organisation
  has_many :issues
end
