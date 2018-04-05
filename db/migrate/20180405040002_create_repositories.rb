class CreateRepositories < ActiveRecord::Migration[5.1]
  def change
    create_table :repositories do |t|
      t.string :repository_name
      t.references :organisation, foreign_key: true

      t.timestamps
    end
  end
end
