module Api
  module V1
    class PedidosController < ApplicationController
      protect_from_forgery with: :null_session

      def index
        pedidos = Pedido.order(created_at: :desc)
        render json: pedidos.as_json(only: %i[id nome_cliente endereco_retirada endereco_entrega item status created_at])
      end

      def show
        pedido = Pedido.find(params[:id])
        render json: pedido.as_json(include: { propostas: { only: %i[id valor status motorista_id] } },
                                    except: [:telefone])
      end

      def create
        pedido = Pedido.new(pedido_params.merge(status: "aberto"))
        if pedido.save
          render json: pedido.as_json(except: [:telefone]), status: :created
        else
          render json: { errors: pedido.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def pedido_params
        params.require(:pedido).permit(:nome_cliente, :telefone, :endereco_retirada, :endereco_entrega, :item, :detalhes)
      end
    end
  end
end

