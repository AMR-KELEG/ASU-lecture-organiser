json.array!(@slides) do |slide|
  json.extract! slide, :id, :path, :lecture_id
  json.url slide_url(slide, format: :json)
end
