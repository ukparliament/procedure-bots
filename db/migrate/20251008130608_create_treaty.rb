class CreateTreaty < ActiveRecord::Migration[8.0]
  def change
    create_table :treaties do |t|
      t.string :uri, :limit => 255, null: false
      t.string :title, null: false
      t.string :lead_organisation_name, :limit => 255, null: false
      t.string :series_citation, :limit => 255, null: false
      t.date :laid_on, null: false
      t.string :procedure_browser_url, :limit => 255, null: false
      t.boolean :posted_to_bluesky, default: false
      t.boolean :posted_to_mastodon, default: false
      t.timestamps
    end
  end
end
