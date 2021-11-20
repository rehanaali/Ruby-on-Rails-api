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

    if(groupByFil)
      return getMessageByFilDeDiscussion
    end

    return getMessageByDestinataire
  end




  private


  def getMessageByFilDeDiscussion
    messages=[]

    ids=Message.select("transmitter_id").group("transmitter_id").actif(Message::ACTIF).where(receiver_id: params['id']).orderdatedesc()
    ids.map(&:transmitter_id).each do|tid|
      messages<< Message.actif(Message::ACTIF).where(receiver_id: params['id'],transmitter_id: tid).orderdatedesc()
    end

    return messages
  end


  def getMessageByDestinataire
     Message.actif(Message::ACTIF).where(receiver_id: params['id']).orderdatedesc()
  end


  def is_a_valid_phone?(phone)
    phone = phone.gsub(/[()-,-._ ]/, '')
    phone =~/^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$/im
  end

end