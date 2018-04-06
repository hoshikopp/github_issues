class RenameColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :repositories, :repository_name, :name
    rename_column :organisations, :organisation_name, :name
    rename_column :issues, :issue_name, :name
  end
end
