class CreateLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :links do |t|
      t.string :short_url
      t.string :url

      t.timestamps
    end

    add_index :links, :short_url, unique: true
  end
end
