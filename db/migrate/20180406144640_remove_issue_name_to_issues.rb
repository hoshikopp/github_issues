class RemoveIssueNameToIssues < ActiveRecord::Migration[5.1]
  def change
    remove_column :issues, :name
  end
end
