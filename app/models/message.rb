class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validates_presence_of :content, :conversation_id, :user_id

  def message_time
    created_at.strftime("%v")
  end

  #TODO send email when a private message is made
end
