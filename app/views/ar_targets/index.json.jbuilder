json.array!(@ar_targets) do |ar_target|
  json.extract! ar_target, :id, :name, :image_url, :data_url, :description
  json.url ar_target_url(ar_target, format: :json)
end
