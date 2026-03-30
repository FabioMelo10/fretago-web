module Api
  module V1
    class MotoristasController < ApplicationController
      protect_from_forgery with: :null_session

      def create
        motorista = Motorista.new(motorista_params.merge(ativo: true))
        if motorista.save
          render json: motorista.as_json(only: %i[id nome email cidade_atuacao tipo_veiculo modelo_veiculo ativo]), status: :created
        else
          render json: { errors: motorista.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def motorista_params
        params.require(:motorista).permit(
          :nome,
          :telefone,
          :email,
          :cpf,
          :renavam,
          :placa_veiculo,
          :tipo_veiculo,
          :modelo_veiculo,
          :ano_veiculo,
          :cidade_atuacao,
          :password,
          :password_confirmation
        )
      end
    end
  end
end
