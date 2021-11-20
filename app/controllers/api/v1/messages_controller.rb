module Api
  module V1
    class MessagesController < ApplicationController

      include MessageService
      include ResponseService

      before_action :set_message, only: [:create]
      before_action :archiver_message, only: [:index]


      ##
      # Fonction qui permet de lister les messages
      # id : correspond à l'id destinataire donc l'id de la table user
      ##
      def index

        if(!params['id'].nil?)
          messages=getMessages(!params['group'].nil? && params['group']=="fil")
          return responseApi('SECCESS', 'Loaded messages', messages)
        end

        return responseApi('ERROR', 'Veuillez vous connecter id absent', {}, :bad_request)

      end


      ##
      # Créer un message
      ##
      def create
           #création de l'objet message
           message = Message.new(message_params)
           #si tout se passe bien on envoir un success message
           if message.save
             return responseApi('SECCESS', 'Saved Message', message)
           end
           #retourner une erreur si l'enregistrement ne passe pas
           return responseApi('ERROR', 'Message not saved', message.errors,:unprocessable_entity)
      end


      private

      ##
      # authorisation des params
      def message_params
        params.permit(:content, :status, :transmitter_id, :receiver_id)
      end


    end
  end
end

