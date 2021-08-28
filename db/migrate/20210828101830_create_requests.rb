class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.references :link, null: false, foreign_key: true
      t.inet :ip

      t.timestamps
    end

    add_index :requests, [:link_id, :ip]
  end
end
