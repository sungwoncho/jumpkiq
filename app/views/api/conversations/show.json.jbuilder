json.partial! 'conversation', conversation: @conversation

json.messages do
  json.partial! 'api/messages/message', collection: @messages, as: :message
end
