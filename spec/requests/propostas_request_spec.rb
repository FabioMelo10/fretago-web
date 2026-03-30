require "rails_helper"

RSpec.describe "Propostas", type: :request do
  let!(:pedido) do
    Pedido.create!(
      nome_cliente: "João",
      telefone: "47999999999",
      endereco_retirada: "A",
      endereco_entrega: "B",
      item: "C",
      status: "novo"
    )
  end

  let!(:motorista) do
    Motorista.create!(
      nome: "Carlos da Silva",
      telefone: "47988888888",
      email: "carlos@example.com",
      cpf: "12345678901",
      renavam: "12345678901",
      placa_veiculo: "ABC1D23",
      tipo_veiculo: "Caminhonete",
      modelo_veiculo: "Hilux",
      cidade_atuacao: "Itajaí",
      password: "SenhaForte123",
      password_confirmation: "SenhaForte123",
      veiculo: "Caminhonete",
      bairro: "Centro",
      ativo: true
    )
  end

  describe "POST /pedidos/:pedido_id/propostas" do
    it "creates a proposta" do
      post motorista_sessao_path, params: { email: motorista.email, password: "SenhaForte123" }

      params = {
        proposta: {
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
      post motorista_sessao_path, params: { email: motorista.email, password: "SenhaForte123" }

      expect do
        post pedido_propostas_path(pedido), params: { proposta: { valor: 0 } }
      end.not_to change(Proposta, :count)

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "PATCH /pedidos/:id/aceitar_proposta" do
    it "accepts one proposal and rejects others and updates pedido" do
      post motorista_sessao_path, params: { email: motorista.email, password: "SenhaForte123" }

      proposta1 = Proposta.create!(pedido:, motorista:, valor: 100, status: "enviada")
      motorista2 = Motorista.create!(
        nome: "Ana Souza",
        telefone: "47988888889",
        email: "ana@example.com",
        cpf: "12345678902",
        renavam: "12345678902",
        placa_veiculo: "DEF1G23",
        tipo_veiculo: "Carro",
        modelo_veiculo: "Onix",
        cidade_atuacao: "Itajaí",
        password: "SenhaForte123",
        password_confirmation: "SenhaForte123",
        veiculo: "Carro",
        bairro: "Centro",
        ativo: true
      )
      proposta2 = Proposta.create!(pedido:, motorista: motorista2, valor: 110, status: "enviada")

      patch aceitar_proposta_pedido_path(pedido, proposta_id: proposta1.id)

      expect(response).to redirect_to(pedido_path(pedido))
      expect(proposta1.reload.status).to eq("aceita")
      expect(proposta2.reload.status).to eq("recusada")
      expect(pedido.reload.status).to eq("fechado")
    end
  end
end
