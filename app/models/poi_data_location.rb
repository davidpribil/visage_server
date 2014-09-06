class PoiDataLocation < ActiveRecord::Base
  belongs_to :poi_data
  validates :poi_data_id, presence: true
  
  serialize :position
  serialize :rotation
  serialize :scale
end
