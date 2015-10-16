json.array!(@projects) do |project|
  json.extract! project, :id, :author, :title, :project_type, :description, :status, :percentage, :image_file
  json.url project_url(project, format: :json)
end
