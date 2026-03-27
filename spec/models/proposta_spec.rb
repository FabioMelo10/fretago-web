require "rails_helper"

RSpec.describe Proposta, type: :model do
  let(:pedido) do
    Pedido.create!(
      nome_cliente: "João",
      telefone: "47999999999",
      endereco_retirada: "A",
      endereco_entrega: "B",
      item: "C",
      status: "novo"
    )
  end

  let(:motorista) do
    Motorista.create!(
      nome: "Carlos",
      telefone: "47988888888",
      veiculo: "Caminhonete",
      bairro: "Centro",
      ativo: true
    )
  end

  it "is valid with valid attributes" do
    proposta = described_class.new(
      pedido:,
      motorista:,
      valor: 100.0,
      mensagem: "Posso retirar hoje à tarde.",
      status: "enviada"
    )

    expect(proposta).to be_valid
  end

  it "requires positive valor" do
    proposta = described_class.new(
      pedido:,
      motorista:,
      valor: 0,
      status: "enviada"
    )

    expect(proposta).not_to be_valid
    expect(proposta.errors[:valor]).to be_present
  end
end


