class Message < ApplicationRecord


  belongs_to :receiver, :class_name => 'User', :foreign_key => 'receiver_id'
  belongs_to :transmitter, :class_name => 'User', :foreign_key => 'transmitter_id'

  #champ status
  STATUS_PUBLIC=1
  STATUS_PRIVATE=2

  #champ actif
  ACTIF=1
  ARCHIVE=0

  validates_with MessageValidator

  scope :actif, ->(actif) {where(actif: actif)}
  scope :orderdatedesc, ->{order(created_at: :desc)}


  def as_json (options= nil)
    super(only: [:content, :status, :created_at], :methods => :transmitter)
  end



end
