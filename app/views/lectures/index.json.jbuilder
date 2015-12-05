json.array!(@lectures) do |lecture|
  json.extract! lecture, :id, :name
  json.url lecture_url(lecture, format: :json)
end
