json.array!(@tasks) do |task|
  json.extract! task, :id, :action_item
  json.url task_url(task, format: :json)
end
