class Proposta < ApplicationRecord
  self.table_name = "propostas"
  STATUSES = %w[enviada aceita recusada].freeze

  belongs_to :pedido
  belongs_to :motorista

  validates :pedido, :motorista, presence: true
  validates :valor, presence: true, numericality: { greater_than: 0 }
  validates :status, presence: true, inclusion: { in: STATUSES }
end


