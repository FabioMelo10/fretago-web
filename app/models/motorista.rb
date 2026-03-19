class Motorista < ApplicationRecord
  self.table_name = "motoristas"

  has_many :propostas, dependent: :nullify

  scope :ativos, -> { where(ativo: true) }

  validates :nome, :telefone, :veiculo, :bairro, presence: true
end
