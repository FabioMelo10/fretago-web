class Pedido < ApplicationRecord
  STATUSES = %w[aberto em_negociacao aceito concluido cancelado].freeze

  has_many :propostas, dependent: :destroy

  validates :nome_cliente, :telefone, :endereco_retirada, :endereco_entrega, :item, presence: true
  validates :status, presence: true, inclusion: { in: STATUSES }
end
