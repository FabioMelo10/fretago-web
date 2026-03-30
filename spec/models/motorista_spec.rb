require "rails_helper"

RSpec.describe Motorista, type: :model do
  def valid_attributes(overrides = {})
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
      password_confirmation: "SenhaForte123",
      ativo: true
    }.merge(overrides)
  end

  it "is valid with valid attributes" do
    motorista = described_class.new(valid_attributes)

    expect(motorista).to be_valid
  end

  it "is invalid without required fields" do
    motorista = described_class.new

    expect(motorista).not_to be_valid
    expect(motorista.errors[:nome]).to be_present
    expect(motorista.errors[:telefone]).to be_present
    expect(motorista.errors[:email]).to be_present
    expect(motorista.errors[:cpf]).to be_present
  end

  it "has ativos scope" do
    ativo = described_class.create!(valid_attributes)
    _inativo = described_class.create!(valid_attributes(email: "inativo@example.com", cpf: "12345678902", renavam: "12345678902", placa_veiculo: "DEF1G23", ativo: false))

    expect(described_class.ativos).to contain_exactly(ativo)
  end
end
