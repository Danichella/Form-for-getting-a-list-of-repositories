class ExtendReposTable < ActiveRecord::Migration[6.1]
  def change
    add_column :repos, :repo_url, :string
  end
end
