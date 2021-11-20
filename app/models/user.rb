class User < ApplicationRecord

  has_many :receiver_messages, :class_name => 'Message', :foreign_key => 'receiver_id'
  has_many :transmitter_messages, :class_name => 'Message', :foreign_key => 'transmitter_id'

  def as_json (options= nil)
    super(only: [:nom, :email])
  end

end
