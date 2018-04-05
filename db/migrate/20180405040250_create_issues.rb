class CreateIssues < ActiveRecord::Migration[5.1]
  def change
    create_table :issues do |t|
      t.string :issue_name
      t.integer :github_id
      t.string :title
      t.string :body
      t.string :html_url
      t.datetime :github_created_at
      t.references :repository, foreign_key: true

      t.timestamps
    end
  end
end
