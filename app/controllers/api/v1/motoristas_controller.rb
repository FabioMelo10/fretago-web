module Api
  module V1
    class MotoristasController < ApplicationController
      protect_from_forgery with: :null_session

      def index
        motoristas = Motorista.ativos.order(:nome)
        render json: motoristas.as_json(only: %i[id nome veiculo bairro ativo])
      end

      def show
        motorista = Motorista.find(params[:id])
        render json: motorista.as_json(only: %i[id nome veiculo bairro ativo])
      end

      def create
        motorista = Motorista.new(motorista_params.merge(ativo: true))
        if motorista.save
          render json: motorista.as_json(only: %i[id nome veiculo bairro ativo]), status: :created
        else
          render json: { errors: motorista.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def motorista_params
        params.require(:motorista).permit(:nome, :telefone, :veiculo, :bairro)
      end
    end
  end
end

