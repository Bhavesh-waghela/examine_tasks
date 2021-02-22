json.extract! question, :id, :question, :q_type, :difficulty_level, :user_id, :created_at, :updated_at
json.url question_url(question, format: :json)
