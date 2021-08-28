class RemoveIndexLinkIdOnRequests < ActiveRecord::Migration[6.0]
  def change
    remove_index :requests, :link_id
  end
end
