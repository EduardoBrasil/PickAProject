json.array!(@projects) do |project|
  json.extract! project, :id, :name, :type_project, :description, :status, :percentage
  json.url project_url(project, format: :json)
end
