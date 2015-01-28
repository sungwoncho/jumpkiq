json.partial! 'conversation', conversation: @conversation

json.messages do
  json.partial! 'messages/message', collection: @messages, as: :message
end
