class CreateMotorista < ActiveRecord::Migration[7.2]
  def change
    create_table :motoristas do |t|
      t.string :nome, null: false
      t.string :telefone, null: false
      t.string :veiculo, null: false
      t.string :bairro, null: false
      t.boolean :ativo, null: false, default: true

      t.timestamps
    end
  end
end
