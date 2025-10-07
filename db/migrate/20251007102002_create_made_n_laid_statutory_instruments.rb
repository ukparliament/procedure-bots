class CreateMadeNLaidStatutoryInstruments < ActiveRecord::Migration[8.0]
  def change
    create_table :made_n_laid_statutory_instruments do |t|
      t.string :uri, :limit => 255, null: false
      t.string :title, :limit => 500, null: false
      t.date :made_on, null: false
      t.date :laid_on, null: false
      t.string :procedure, :limit => 255, null: false
      t.string :procedure_browser_url, :limit => 255, null: false
      t.boolean :posted_to_bluesky, default: false
      t.boolean :posted_to_mastodon, default: false
      t.timestamps
    end
  end
end