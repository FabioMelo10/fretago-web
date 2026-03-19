require "rails_helper"

RSpec.describe "Propostas", type: :request do
  let!(:pedido) do
    Pedido.create!(
      nome_cliente: "João",
      telefone: "47999999999",
      endereco_retirada: "A",
      endereco_entrega: "B",
      item: "C",
      status: "aberto"
    )
  end

  let!(:motorista) do
    Motorista.create!(
      nome: "Carlos",
      telefone: "47988888888",
      veiculo: "Caminhonete",
      bairro: "Centro",
      ativo: true
    )
  end

  describe "POST /pedidos/:pedido_id/propostas" do
    it "creates a proposta" do
      params = {
        proposta: {
          motorista_id: motorista.id,
          valor: 120.0,
          mensagem: "Posso hoje à tarde"
        }
      }

      expect do
        post pedido_propostas_path(pedido), params:
      end.to change(Proposta, :count).by(1)

      expect(response).to redirect_to(pedido_path(pedido))
      expect(Proposta.last.status).to eq("enviada")
    end

    it "handles invalid data" do
      expect do
        post pedido_propostas_path(pedido), params: { proposta: { motorista_id: motorista.id, valor: 0 } }
      end.not_to change(Proposta, :count)

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "PATCH /pedidos/:id/aceitar_proposta" do
    it "accepts one proposal and rejects others and updates pedido" do
      proposta1 = Proposta.create!(pedido:, motorista:, valor: 100, status: "enviada")
      motorista2 = Motorista.create!(nome: "Ana", telefone: "1", veiculo: "Carro", bairro: "Centro", ativo: true)
      proposta2 = Proposta.create!(pedido:, motorista: motorista2, valor: 110, status: "enviada")

      patch aceitar_proposta_pedido_path(pedido, proposta_id: proposta1.id)

      expect(response).to redirect_to(pedido_path(pedido))
      expect(proposta1.reload.status).to eq("aceita")
      expect(proposta2.reload.status).to eq("recusada")
      expect(pedido.reload.status).to eq("aceito")
    end
  end
end

