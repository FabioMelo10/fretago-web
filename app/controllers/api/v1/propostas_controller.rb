module Api
  module V1
    class PropostasController < ApplicationController
      protect_from_forgery with: :null_session

      before_action :set_pedido, only: :create

      def index
        propostas = Proposta.includes(:pedido, :motorista).order(created_at: :desc)
        render json: propostas.as_json(
          only: %i[id valor status mensagem],
          include: {
            pedido: { only: %i[id item status] },
            motorista: { only: %i[id nome veiculo bairro] }
          }
        )
      end

      def show
        proposta = Proposta.find(params[:id])
        render json: proposta.as_json(
          only: %i[id valor status mensagem],
          include: {
            pedido: { only: %i[id item status endereco_retirada endereco_entrega] },
            motorista: { only: %i[id nome veiculo bairro] }
          }
        )
      end

      def create
        proposta = @pedido.propostas.new(proposta_params.merge(status: "enviada"))
        if proposta.save
          render json: proposta.as_json(only: %i[id valor status mensagem pedido_id motorista_id]), status: :created
        else
          render json: { errors: proposta.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def aceitar
        proposta = Proposta.find(params[:id])
        pedido = proposta.pedido

        Pedido.transaction do
          pedido.propostas.where.not(id: proposta.id).update_all(status: "recusada")
          proposta.update!(status: "aceita")
          pedido.update!(status: "aceito")
        end

        render json: {
          pedido: pedido.as_json(only: %i[id status]),
          proposta: proposta.as_json(only: %i[id status])
        }, status: :ok
      rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotFound
        render json: { error: "Não foi possível aceitar esta proposta" }, status: :unprocessable_entity
      end

      private

      def set_pedido
        @pedido = Pedido.find(params[:pedido_id])
      end

      def proposta_params
        params.require(:proposta).permit(:motorista_id, :valor, :mensagem)
      end
    end
  end
end

