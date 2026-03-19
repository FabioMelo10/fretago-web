require "rails_helper"

RSpec.describe "Motoristas", type: :request do
  describe "POST /motoristas" do
    it "creates a motorista" do
      params = {
        motorista: {
          nome: "Carlos",
          telefone: "47988888888",
          veiculo: "Caminhonete",
          bairro: "Centro"
        }
      }

      expect do
        post motoristas_path, params:
      end.to change(Motorista, :count).by(1)

      expect(response).to redirect_to(root_path)
    end

    it "handles invalid data" do
      expect do
        post motoristas_path, params: { motorista: { nome: "" } }
      end.not_to change(Motorista, :count)

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end

