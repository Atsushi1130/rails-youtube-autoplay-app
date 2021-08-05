class Playlist < ApplicationRecord
  validates :name,{presence: true}
end
