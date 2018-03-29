json.extract! comment, :id, :submission_id, :body, :title, :user_id, :created_at, :updated_at
json.url comment_url(comment, format: :json)
