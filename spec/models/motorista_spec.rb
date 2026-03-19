require "rails_helper"

RSpec.describe Motorista, type: :model do
  it "is valid with valid attributes" do
    motorista = described_class.new(
      nome: "Carlos",
      telefone: "47988888888",
      veiculo: "Caminhonete",
      bairro: "Centro"
    )

    expect(motorista).to be_valid
  end

  it "is invalid without required fields" do
    motorista = described_class.new

    expect(motorista).not_to be_valid
    expect(motorista.errors[:nome]).to be_present
    expect(motorista.errors[:telefone]).to be_present
    expect(motorista.errors[:veiculo]).to be_present
    expect(motorista.errors[:bairro]).to be_present
  end

  it "has ativos scope" do
    ativo = described_class.create!(nome: "A", telefone: "1", veiculo: "Carro", bairro: "Centro", ativo: true)
    _inativo = described_class.create!(nome: "B", telefone: "2", veiculo: "Carro", bairro: "Centro", ativo: false)

    expect(described_class.ativos).to contain_exactly(ativo)
  end
end
