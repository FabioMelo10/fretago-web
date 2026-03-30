class ExpandMotoristasForAuthentication < ActiveRecord::Migration[7.2]
  def change
    add_column :motoristas, :email, :string
    add_column :motoristas, :cpf, :string
    add_column :motoristas, :renavam, :string
    add_column :motoristas, :placa_veiculo, :string
    add_column :motoristas, :tipo_veiculo, :string
    add_column :motoristas, :modelo_veiculo, :string
    add_column :motoristas, :ano_veiculo, :integer
    add_column :motoristas, :cidade_atuacao, :string
    add_column :motoristas, :password_digest, :string

    add_index :motoristas, :email, unique: true
    add_index :motoristas, :cpf, unique: true
    add_index :motoristas, :renavam, unique: true
    add_index :motoristas, :placa_veiculo, unique: true
  end
end
