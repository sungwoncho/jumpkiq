json.(message, :body, :is_read, :created_at)
json.is_receiver message.receiver_type == 'User'
