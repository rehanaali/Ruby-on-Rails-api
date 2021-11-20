class MessageValidator < ActiveModel::Validator

  def validate(record)

    if(record.content.nil?)
      record.errors.add(:message, "votre message est vide ")
    end

    if(!(record.status.to_i)  || !(record.status.to_i >= 1) || !(record.status.to_i <= 2))
      record.errors.add(:message, "Votre status est vide: message privé (2) ou publique (1) ? ")
    end

    if(!(record.transmitter_id.to_i)  || !(record.transmitter_id.to_i >= 1))
      record.errors.add(:message, "transmitter_id est un champ entier obligatoire")
    end

    if(!(record.receiver_id.to_i)  || !(record.receiver_id.to_i >= 1))
      record.errors.add(:message, "receiver_id est un champ entier obligatoire")
    end

    if(record.transmitter_id == record.receiver_id)
      record.errors.add(:message, "vous être entrain de vous envoyer un message !!! ")
    end

  end


end