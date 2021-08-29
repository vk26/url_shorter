class Request < ApplicationRecord
  belongs_to :link

  validates_presence_of :link_id, :ip
end
