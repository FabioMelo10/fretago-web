class Pedido < ApplicationRecord
  enum :status, {
    novo: "novo",
    em_negociacao: "em_negociacao",
    fechado: "fechado",
    cancelado: "cancelado"
  }, default: :novo, validate: true

  has_many :propostas, dependent: :destroy

  validates :nome_cliente, :telefone, :endereco_retirada, :endereco_entrega, :item, presence: true
end
