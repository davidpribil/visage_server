class Poi < ActiveRecord::Base
  belongs_to :area
  validates :area_id, presence: true 
  has_many :poi_datas
  has_many :poi_data_locations, through: :poi_datas
  
  after_create :create_text_poi_data
  
  private
    def create_text_poi_data
      self.poi_datas.create(data_type: "text");
    end
end
