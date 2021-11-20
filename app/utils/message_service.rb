module MessageService

  @@confidentiel="confidentiel"

  #remplacer automatiquement less emails et numéro de téléphone contenus dans les
  # messages par le mot « confidentiel »
  def set_message
    if (!params[:content].nil?)

      tabToreturn = []

      wordsTab=params[:content].split
      wordsTab.each do|word|

        if (word =~ URI::MailTo::EMAIL_REGEXP || is_a_valid_phone?(word) )
          word=@@confidentiel
        end

        tabToreturn<<word
        params[:content] = tabToreturn.join(" ")
      end
    end
  end



  #archiver les messages de plus de 3 mois
  def archiver_message
    Message.where('created_at < ?', 3.month.ago).update_all(actif: Message::ARCHIVE)
  end


  ##
  # retourner les messages actifs par ordre chronologique ou par fil de discussion
  #
  def getMessages(groupByFil=false)

    messages=Message.actif(Message::ACTIF).where(receiver_id: params['id']).orderdatedesc()

    if(groupByFil)
      return messages.group("transmitter_id")
    end

    return messages

  end




  private

  def is_a_valid_phone?(phone)
    phone = phone.gsub(/[()-,-._ ]/, '')
    phone =~/^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$/im
  end

end