class PoiData < ActiveRecord::Base
  belongs_to :poi
  validates :poi_id, presence: true
  has_many :poi_data_locations
  enum data_type: {undefined: 100, marker_image: 101, metaio_config: 102, texture2D: 0, object3D: 1, audio: 2, text: 3, image: 4}
end
