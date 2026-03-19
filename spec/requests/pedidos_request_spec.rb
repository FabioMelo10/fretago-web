require "rails_helper"

RSpec.describe "Pedidos", type: :request do
  describe "POST /pedidos" do
    it "creates a pedido" do
      params = {
        pedido: {
          nome_cliente: "João",
          telefone: "47999999999",
          endereco_retirada: "A",
          endereco_entrega: "B",
          item: "C",
          detalhes: "Fragil"
        }
      }

      expect do
        post pedidos_path, params:
      end.to change(Pedido, :count).by(1)

      expect(response).to redirect_to(pedido_path(Pedido.last))
    end

    it "handles invalid data" do
      expect do
        post pedidos_path, params: { pedido: { nome_cliente: "" } }
      end.not_to change(Pedido, :count)

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end

