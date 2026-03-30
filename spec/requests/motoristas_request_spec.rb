require "rails_helper"

RSpec.describe "Motoristas", type: :request do
  def valid_motorista_params
    {
      nome: "Carlos da Silva",
      telefone: "47988888888",
      email: "carlos@example.com",
      cpf: "12345678901",
      renavam: "12345678901",
      placa_veiculo: "ABC1D23",
      tipo_veiculo: "Caminhonete",
      modelo_veiculo: "Hilux",
      ano_veiculo: 2020,
      cidade_atuacao: "Itajaí",
      password: "SenhaForte123",
      password_confirmation: "SenhaForte123"
    }
  end

  describe "POST /motoristas" do
    it "creates a motorista" do
      expect do
        post motoristas_path, params: { motorista: valid_motorista_params }
      end.to change(Motorista, :count).by(1)

      expect(response).to redirect_to(motorista_painel_path)
    end

    it "handles invalid data" do
      expect do
        post motoristas_path, params: { motorista: { nome: "" } }
      end.not_to change(Motorista, :count)

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
