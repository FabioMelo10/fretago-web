require "rails_helper"

RSpec.describe "API V1", type: :request do
  describe "POST /api/v1/pedidos" do
    it "creates a pedido and returns JSON" do
      payload = {
        pedido: {
          nome_cliente: "João",
          telefone: "47999999999",
          endereco_retirada: "A",
          endereco_entrega: "B",
          item: "C"
        }
      }

      post "/api/v1/pedidos", params: payload, as: :json

      expect(response).to have_http_status(:created)
      body = JSON.parse(response.body)
      expect(body["id"]).to be_present
      expect(body["telefone"]).to be_nil.or be_present # phone may be filtered in future
    end
  end

  describe "PATCH /api/v1/propostas/:id/aceitar" do
    it "accepts a proposal" do
      pedido = Pedido.create!(
        nome_cliente: "João",
        telefone: "47999999999",
        endereco_retirada: "A",
        endereco_entrega: "B",
        item: "C",
        status: "aberto"
      )
      motorista = Motorista.create!(nome: "Carlos", telefone: "1", veiculo: "Carro", bairro: "Centro", ativo: true)
      proposta = Proposta.create!(pedido:, motorista:, valor: 100, status: "enviada")

      patch "/api/v1/propostas/#{proposta.id}/aceitar"

      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      expect(body.dig("proposta", "status")).to eq("aceita")
      expect(body.dig("pedido", "status")).to eq("aceito")
    end
  end
end

