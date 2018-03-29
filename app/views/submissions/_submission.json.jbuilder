json.extract! submission, :id, :title, :lead, :body, :created_at, :updated_at
json.url submission_url(submission, format: :json)
