class ChangeColumnsToLinks < ActiveRecord::Migration[6.0]
  def change
    change_column_null :links, :url, false
    change_column_null :links, :short_url, false
  end
end
