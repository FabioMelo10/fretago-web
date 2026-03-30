class Motorista < ApplicationRecord
  self.table_name = "motoristas"

  has_many :propostas, dependent: :nullify
  has_secure_password

  scope :ativos, -> { where(ativo: true) }

  before_validation :normalize_attributes

  validates :nome, :telefone, :email, :cpf, :renavam, :placa_veiculo, :tipo_veiculo, :modelo_veiculo, :cidade_atuacao, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: { case_sensitive: false }
  validates :cpf, length: { is: 11 }, uniqueness: true
  validates :telefone, length: { minimum: 10, maximum: 11 }
  validates :renavam, length: { in: 9..11 }, uniqueness: true
  validates :placa_veiculo, format: { with: /\A[A-Z]{3}[0-9][A-Z0-9][0-9]{2}\z/ }, uniqueness: true
  validates :ano_veiculo, numericality: { only_integer: true, greater_than_or_equal_to: 1980, less_than_or_equal_to: Date.current.year + 1 }, allow_blank: true
  validates :password, length: { minimum: 8 }, if: :password_required?

  private

  def normalize_attributes
    self.nome = nome.to_s.strip.squish
    self.telefone = telefone.to_s.gsub(/\D/, "")
    self.email = email.to_s.strip.downcase
    self.cpf = cpf.to_s.gsub(/\D/, "")
    self.renavam = renavam.to_s.gsub(/\D/, "")
    self.placa_veiculo = placa_veiculo.to_s.gsub(/[^a-zA-Z0-9]/, "").upcase
    self.tipo_veiculo = tipo_veiculo.to_s.strip
    self.modelo_veiculo = modelo_veiculo.to_s.strip
    self.cidade_atuacao = cidade_atuacao.to_s.strip

    # Campos legados mantidos preenchidos para compatibilidade com fluxos antigos.
    self.veiculo = [tipo_veiculo, modelo_veiculo].compact_blank.join(" - ").presence || veiculo
    self.bairro = cidade_atuacao if bairro.blank?
  end

  def password_required?
    new_record? || password.present?
  end
end
