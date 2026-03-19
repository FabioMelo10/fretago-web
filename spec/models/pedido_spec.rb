require "rails_helper"

RSpec.describe Pedido, type: :model do
  it "is valid with valid attributes" do
    pedido = described_class.new(
      nome_cliente: "João",
      telefone: "47999999999",
      endereco_retirada: "Bairro Centro, Itajaí",
      endereco_entrega: "Bairro Fazenda, Itajaí",
      item: "Geladeira",
      status: "aberto"
    )

    expect(pedido).to be_valid
  end

  it "is invalid without required fields" do
    pedido = described_class.new

    expect(pedido).not_to be_valid
    expect(pedido.errors[:nome_cliente]).to be_present
    expect(pedido.errors[:telefone]).to be_present
    expect(pedido.errors[:endereco_retirada]).to be_present
    expect(pedido.errors[:endereco_entrega]).to be_present
    expect(pedido.errors[:item]).to be_present
  end

  it "requires a valid status" do
    pedido = described_class.new(
      nome_cliente: "João",
      telefone: "47999999999",
      endereco_retirada: "A",
      endereco_entrega: "B",
      item: "C",
      status: "invalido"
    )

    expect(pedido).not_to be_valid
    expect(pedido.errors[:status]).to be_present
  end
end
